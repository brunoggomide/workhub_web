import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:workhub_web/src/controllers/desks/desk_controller.dart';
import 'package:workhub_web/src/models/desk_model.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/user/user_controller.dart';
import '../../services/cep.dart';
import '../utils/timeFormat.dart';
import 'components/moneyFormat.dart';

class EditDesk extends StatefulWidget {
  final String id;

  const EditDesk({
    super.key,
    required this.id,
  });

  @override
  _EditDeskState createState() => _EditDeskState();
}

class _EditDeskState extends State<EditDesk> {
  final DeskController deskController = DeskController();
  Desk? _desk;

  final _tituloController = TextEditingController();
  final _valorController = TextEditingController();
  final _numMesasController = TextEditingController();
  final _cepController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _numeroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _ufController = TextEditingController();
  final _bairroController = TextEditingController();
  final _complementoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _aberturaController = TextEditingController();
  final _fechamentoController = TextEditingController();
  final MoneyTextInputFormatter _moneyFormatter = MoneyTextInputFormatter();
  final HourTextInputFormatter _hourFormatter = HourTextInputFormatter();
  var numMesasNow;
  bool cafe = false;
  bool estacionamento = false;
  bool arCondicionado = false;
  bool espacoInterativo = false;
  bool bicicletario = false;
  bool acessibilidade = false;
  List<File> _pickedImages = [];
  List<Uint8List> _pickedImagesWeb = [];
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
  void initState() {
    super.initState();
    loadDesk();
  }

  void loadDesk() async {
    _desk = await deskController.getDesk(widget.id);

    var data = _desk!.toJson();
    _cepController.text = data['cep'] ?? '';
    _enderecoController.text = data['endereco'] ?? '';
    _numeroController.text = data['num_endereco'] ?? '';
    _bairroController.text = data['bairro'] ?? '';
    _complementoController.text = data['complemento'] ?? '';
    _cidadeController.text = data['cidade'] ?? '';
    _ufController.text = data['uf'] ?? '';
    _tituloController.text = data['titulo'] ?? '';
    _aberturaController.text = data['hr_abertura'] ?? '';
    _fechamentoController.text = data['hr_fechamento'] ?? '';
    _descricaoController.text = data['descricao'] ?? '';
    _valorController.text = data['valor'] ?? '';
    _numMesasController.text = data['num_mesas'] ?? '';
    acessibilidade = data['acessibilidade'] ?? false;
    arCondicionado = data['ar_condicionado'] ?? false;
    espacoInterativo = data['espaco_interativo'] ?? false;
    bicicletario = data['bicicletario'] ?? false;
    cafe = data['cafe'] ?? false;
    estacionamento = data['estacionamento'] ?? false;

    _pickedImagesWeb = await deskController.downloadImages(data['fotos']);

    numMesasNow = data['num_mesas'];
    setState(() {});
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
                            'Editar Mesa',
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
                                controller: _tituloController,
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
                                inputFormatters: [_hourFormatter],
                                decoration: InputDecoration(
                                  labelText: 'Abertura',
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
                                controller: _fechamentoController,
                                inputFormatters: [_hourFormatter],
                                decoration: InputDecoration(
                                  labelText: 'Fechamento',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: TextFormField(
                                controller: _valorController,
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
                                controller: _numMesasController,
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
                                        _ufController.text =
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
                                controller: _numeroController,
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
                                controller: _ufController,
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
                                controller: _complementoController,
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
                          controller: _descricaoController,
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
                                                          .remove(image);
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
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                side: const BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(177, 47, 47, 1)),
                              ),
                              onPressed: () async {
                                int numMesas =
                                    await DeskController().contarMesas();
                                dynamic planDesk =
                                    await UserController().getPlanDesk();
                                String inputText = _numMesasController.text;
                                int additionalMesas = int.parse(inputText);
                                int mesasNow = int.parse(numMesasNow);

                                var mesas =
                                    numMesas + additionalMesas - mesasNow;
                                if (mesas <= planDesk) {
                                  if (_tituloController.text.isNotEmpty &&
                                      _valorController.text.isNotEmpty &&
                                      _numMesasController.text.isNotEmpty &&
                                      _cepController.text.isNotEmpty &&
                                      _enderecoController.text.isNotEmpty &&
                                      _numeroController.text.isNotEmpty &&
                                      _cidadeController.text.isNotEmpty &&
                                      _ufController.text.isNotEmpty &&
                                      _bairroController.text.isNotEmpty &&
                                      _descricaoController.text.isNotEmpty &&
                                      _pickedImagesWeb.isNotEmpty) {
                                    var d = Desk(
                                      UID_coworking:
                                          AuthController().idUsuario(),
                                      titulo: _tituloController.text,
                                      valor: _valorController.text,
                                      num_mesas: _numMesasController.text,
                                      cep: _cepController.text,
                                      endereco: _enderecoController.text,
                                      num_endereco: _numeroController.text,
                                      cidade: _cidadeController.text,
                                      uf: _ufController.text,
                                      bairro: _bairroController.text,
                                      complemento: _complementoController.text,
                                      descricao: _descricaoController.text,
                                      cafe: cafe,
                                      estacionamento: estacionamento,
                                      ar_condicionado: arCondicionado,
                                      espaco_interativo: espacoInterativo,
                                      bicicletario: bicicletario,
                                      acessibilidade: acessibilidade,
                                      criado_em: DateTime.now().toString(),
                                      atualizado_em: DateTime.now().toString(),
                                      hr_abertura: _aberturaController.text,
                                      hr_fechamento: _fechamentoController.text,
                                    );
                                    deskController.updateDesk(widget.id, d,
                                        _pickedImagesWeb, context);
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
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red[300],
                                      content: const Text(
                                          'Você ultrapassou o limite de cadastros de mesas do seu plano.'),
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
