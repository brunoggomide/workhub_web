import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:workhub_web/src/controllers/desks/desk_controller.dart';
import 'package:workhub_web/src/models/desk_model.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../services/cep.dart';
import 'components/moneyFormat.dart';

class NewDesk extends StatefulWidget {
  const NewDesk({Key? key}) : super(key: key);

  @override
  _NewDeskState createState() => _NewDeskState();
}

class _NewDeskState extends State<NewDesk> {
  final _formKey = GlobalKey<FormState>();
  final _titleName = TextEditingController();
  final _valueHour = TextEditingController();
  final _numTables = TextEditingController();
  final _cepController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _numAddress = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _bairroController = TextEditingController();
  final _complementoAddress = TextEditingController();
  final _description = TextEditingController();
  final MoneyTextInputFormatter _moneyFormatter = MoneyTextInputFormatter();
  bool cafe = false;
  bool estacionamento = false;
  bool arCondicionado = false;
  bool espacoInterativo = false;
  bool bicicletario = false;
  bool acessibilidade = false;
  final cepFormat = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  final deskFormat = MaskTextInputFormatter(
    mask: '####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 1000.0,
        padding: const EdgeInsets.all(16.0),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Nova Posição',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _titleName,
                                decoration: InputDecoration(
                                  labelText: 'Nome da Posição',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              child: TextFormField(
                                controller: _valueHour,
                                inputFormatters: [_moneyFormatter],
                                decoration: InputDecoration(
                                  labelText: 'Valor da Hora',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              child: TextFormField(
                                controller: _numTables,
                                inputFormatters: [deskFormat],
                                decoration: InputDecoration(
                                  labelText: 'Mesas',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: _cepController,
                                inputFormatters: [cepFormat],
                                onChanged: (cep) {
                                  if (cep.length == 9) {
                                    getAddress(cep).then((address) {
                                      setState(() {
                                        _enderecoController.text =
                                            address['logradouro'] ?? '';
                                        _cidadeController.text =
                                            address['localidade'] ?? '';
                                        _estadoController.text =
                                            address['uf'] ?? '';
                                        _bairroController.text =
                                            address['bairro'] ?? '';
                                      });
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Cep',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                controller: _enderecoController,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Endereço',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: _numAddress,
                                decoration: InputDecoration(
                                  labelText: 'Número',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _cidadeController,
                                decoration: InputDecoration(
                                  enabled: false,
                                  labelText: 'Cidade',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: _estadoController,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Estado',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _bairroController,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Bairro',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _complementoAddress,
                                decoration: InputDecoration(
                                  labelText: 'Complemento',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          controller: _description,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Descrição',
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.coffee,
                                        size: 20,
                                      ),
                                      Text('Café'),
                                    ],
                                  ),
                                  Switch(
                                    value: cafe,
                                    onChanged: (value) {
                                      setState(() {
                                        cafe = value;
                                        // Adicione ação desejada aqui
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 6.0),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.local_parking,
                                        size: 20,
                                      ),
                                      Text('Estacionamento'),
                                    ],
                                  ),
                                  Switch(
                                    value: estacionamento,
                                    onChanged: (value) {
                                      setState(() {
                                        estacionamento = value;
                                        // Adicione ação desejada aqui
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 6.0),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.severe_cold,
                                        size: 20,
                                      ),
                                      Text('Ar-Condicionado'),
                                    ],
                                  ),
                                  Switch(
                                    value: arCondicionado,
                                    onChanged: (value) {
                                      setState(() {
                                        arCondicionado = value;
                                        // Adicione ação desejada aqui
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.interests,
                                        size: 20,
                                      ),
                                      Text('Espaço interativo'),
                                    ],
                                  ),
                                  Switch(
                                    value: espacoInterativo,
                                    onChanged: (value) {
                                      setState(() {
                                        espacoInterativo = value;
                                        // Adicione ação desejada aqui
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 6.0),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.pedal_bike,
                                        size: 20,
                                      ),
                                      Text('Bicicletário'),
                                    ],
                                  ),
                                  Switch(
                                    value: bicicletario,
                                    onChanged: (value) {
                                      setState(() {
                                        bicicletario = value;
                                        // Adicione ação desejada aqui
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 6.0),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.wheelchair_pickup,
                                        size: 20,
                                      ),
                                      Text('Acessibilidade'),
                                    ],
                                  ),
                                  Switch(
                                    value: acessibilidade,
                                    onChanged: (value) {
                                      setState(() {
                                        acessibilidade = value;
                                        // Adicione ação desejada aqui
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: 120,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                side: const BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(177, 47, 47, 1)),
                              ),
                              onPressed: () {
                                if (_titleName.text.isNotEmpty &&
                                    _valueHour.text.isNotEmpty &&
                                    _numTables.text.isNotEmpty &&
                                    _cepController.text.isNotEmpty &&
                                    _enderecoController.text.isNotEmpty &&
                                    _numAddress.text.isNotEmpty &&
                                    _cidadeController.text.isNotEmpty &&
                                    _estadoController.text.isNotEmpty &&
                                    _bairroController.text.isNotEmpty &&
                                    _complementoAddress.text.isNotEmpty &&
                                    _description.text.isNotEmpty) {
                                  var d = Desk(
                                    AuthController().idUsuario(),
                                    _titleName.text,
                                    _valueHour.text,
                                    _numTables.text,
                                    _cepController.text,
                                    _enderecoController.text,
                                    _numAddress.text,
                                    _cidadeController.text,
                                    _estadoController.text,
                                    _bairroController.text,
                                    _complementoAddress.text,
                                    _description.text,
                                    cafe,
                                    estacionamento,
                                    arCondicionado,
                                    espacoInterativo,
                                    bicicletario,
                                    acessibilidade,
                                    '00',
                                    '',
                                    true,
                                  );
                                  DeskController().adicionar(context, d);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red[300],
                                      content: const Text(
                                        'Preencha todos os campos',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'SALVAR',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(177, 47, 47, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      color: Colors.red,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
