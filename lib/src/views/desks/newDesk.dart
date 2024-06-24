import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:workhub_web/src/controllers/desks/desk_controller.dart';
import 'package:workhub_web/src/models/desk_model.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/user/user_controller.dart';
import '../../services/cep.dart';
import '../utils/moneyFormat.dart';

class NewDesk extends StatefulWidget {
  const NewDesk({Key? key}) : super(key: key);

  @override
  _NewDeskState createState() => _NewDeskState();
}

class _NewDeskState extends State<NewDesk> {
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
  final _aberturaController = TextEditingController();
  final _fechamentoController = TextEditingController();
  final MoneyTextInputFormatter _moneyFormatter = MoneyTextInputFormatter();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  bool cafe = false;
  bool estacionamento = false;
  bool arCondicionado = false;
  bool espacoInterativo = false;
  bool bicicletario = false;
  bool acessibilidade = false;
  final List<File> _pickedImages = [];
  final List<Uint8List> _pickedImagesWeb = [];
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

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text = picked.format(context);
      setState(() {});
    }
  }

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
                            'Nova Mesa',
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
                            const SizedBox(width: 12.0),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: _aberturaController,
                                readOnly: true,
                                onTap: () =>
                                    _selectTime(context, _aberturaController),
                                decoration: InputDecoration(
                                  labelText: 'Abertura',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  suffixIcon: Icon(Icons.access_time),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: _fechamentoController,
                                readOnly: true,
                                onTap: () =>
                                    _selectTime(context, _fechamentoController),
                                decoration: InputDecoration(
                                  labelText: 'Fechamento',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  suffixIcon: Icon(Icons.access_time),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
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
                                enabled: _cepController.text.isNotEmpty &&
                                        _enderecoController.text.isEmpty
                                    ? true
                                    : false,
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
                                enabled: _cepController.text.isNotEmpty &&
                                        _bairroController.text.isEmpty
                                    ? true
                                    : false,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 6.0),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 6.0),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.ac_unit,
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
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 6.0),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 6.0),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey),
                                        fixedSize: MaterialStateProperty.all(
                                            const Size(200, 40)),
                                      ),
                                      onPressed: () => _pickImage(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.upload_file_outlined),
                                          Text(' Selecionar imagens'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: _pickedImagesWeb
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        int index = entry.key;
                                        Uint8List image = entry.value;
                                        return Container(
                                          width: 100,
                                          height: 100,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Image.memory(
                                                image,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Colors.black54,
                                                ),
                                                child: IconButton(
                                                  icon: Icon(Icons.close,
                                                      color: Colors.white),
                                                  onPressed: () {
                                                    setState(() {
                                                      _pickedImagesWeb
                                                          .removeAt(index);
                                                      _pickedImages
                                                          .removeAt(index);
                                                    });
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Center(
                          child: SizedBox(
                              height: 50,
                              width: 120,
                              child: RoundedLoadingButton(
                                controller: _btnController,
                                onPressed: () async {
                                  int numMesas =
                                      await DeskController().contarMesas();
                                  dynamic planDesk =
                                      await UserController().getPlanDesk();
                                  String inputText = _numTables.text;
                                  int additionalMesas = int.parse(inputText);
                                  var mesas = numMesas + additionalMesas;
                                  String horaAbertura =
                                      _aberturaController.text;
                                  String horaFechamento =
                                      _fechamentoController.text;
                                  if (mesas <= planDesk) {
                                    if (_titleName.text.isNotEmpty &&
                                        _valueHour.text.isNotEmpty &&
                                        _numTables.text.isNotEmpty &&
                                        _cepController.text.isNotEmpty &&
                                        _enderecoController.text.isNotEmpty &&
                                        _numAddress.text.isNotEmpty &&
                                        _cidadeController.text.isNotEmpty &&
                                        _estadoController.text.isNotEmpty &&
                                        _bairroController.text.isNotEmpty &&
                                        _description.text.isNotEmpty) {
                                      if (horaFechamento
                                              .compareTo(horaAbertura) <
                                          0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                'A hora de fechamento não pode ser menor que a hora de abertura.'),
                                            duration: Duration(seconds: 4),
                                          ),
                                        );
                                        _btnController.reset();
                                      } else {
                                        var d = Desk(
                                          UID_coworking:
                                              AuthController().idUsuario(),
                                          titulo: _titleName.text,
                                          valor: _valueHour.text,
                                          num_mesas: _numTables.text,
                                          cep: _cepController.text,
                                          endereco: _enderecoController.text,
                                          num_endereco: _numAddress.text,
                                          cidade: _cidadeController.text,
                                          uf: _estadoController.text,
                                          bairro: _bairroController.text,
                                          complemento: _complementoAddress.text,
                                          descricao: _description.text,
                                          cafe: cafe,
                                          estacionamento: estacionamento,
                                          ar_condicionado: arCondicionado,
                                          espaco_interativo: espacoInterativo,
                                          bicicletario: bicicletario,
                                          acessibilidade: acessibilidade,
                                          criado_em: DateTime.now().toString(),
                                          atualizado_em:
                                              DateTime.now().toString(),
                                          hr_abertura: _aberturaController.text,
                                          hr_fechamento:
                                              _fechamentoController.text,
                                        );
                                        DeskController().addDesk(
                                            d, _pickedImagesWeb, context);

                                        // Simula o tempo de carregamento
                                        Future.delayed(
                                            const Duration(seconds: 10), () {
                                          _btnController.success();
                                        });
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red[300],
                                          content: const Text(
                                            'Preencha todos os campos',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          duration: const Duration(seconds: 3),
                                        ),
                                      );
                                      _btnController.reset();
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red[300],
                                        content: const Text(
                                            'Você ultrapassou o limite de cadastros de mesas do seu plano.'),
                                      ),
                                    );
                                    _btnController.reset();
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
                                color: Colors.transparent,
                                successColor: Colors.green,
                                width: 200,
                                borderRadius: 4,
                              )),
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

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      List<XFile>? images = await _picker.pickMultiImage();
      if (images != null) {
        var selected = images.map((image) => File(image.path)).toList();
        setState(() {
          _pickedImages.addAll(selected);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Nenhuma imagem selecionada.'),
          ),
        );
      }
    } else {
      final ImagePicker _picker = ImagePicker();
      List<XFile>? images = await _picker.pickMultiImage();
      if (images != null) {
        var files =
            await Future.wait(images.map((image) => image.readAsBytes()));
        setState(() {
          _pickedImagesWeb.addAll(files);
          _pickedImages.addAll(images.map((image) => File('a')).toList());
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Nenhuma imagem selecionada.'),
          ),
        );
      }
    }
  }
}
