import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../controllers/meeting_room/meeting_room_controller.dart';
import '../../../../models/meeting_room_model.dart';
import '../../../../services/cep.dart';
import '../../../utils/moneyFormat.dart';
import '../../../utils/timeFormat.dart';

class EditMeetingRoomForm extends StatefulWidget {
  final String documentId;

  const EditMeetingRoomForm({
    super.key,
    required this.documentId,
  });

  @override
  State<EditMeetingRoomForm> createState() => _EditMeetingRoomFormState();
}

class _EditMeetingRoomFormState extends State<EditMeetingRoomForm> {
  final MeetingRoomController meetingRoomController = MeetingRoomController();
  MeetingRoom? _meetingRoom;

  final TextEditingController cepController = TextEditingController();
  final TextEditingController logradouroController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();
  late String selectedUf;
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController ufController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController aberturaController = TextEditingController();
  final TextEditingController fechamentoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController capacidadeController = TextEditingController();
  final MoneyTextInputFormatter _moneyFormatter = MoneyTextInputFormatter();
  final HourTextInputFormatter _hourFormatter = HourTextInputFormatter();

  final ValueNotifier<bool> acessibilidadeController =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> arCondicionadoController =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> projetorController = ValueNotifier<bool>(false);
  final ValueNotifier<bool> quadroBrancoController = ValueNotifier<bool>(false);
  final ValueNotifier<bool> tvController = ValueNotifier<bool>(false);
  final ValueNotifier<bool> videoconferenciaController =
      ValueNotifier<bool>(false);

  final cepFormat = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  final List<File> _pickedImages = [];
  List<Uint8List> _pickedImagesWeb = [];

  DateTime? dtCriacao;

  @override
  void initState() {
    super.initState();
    loadMeetingRoom();
  }

  void loadMeetingRoom() async {
    _meetingRoom =
        await meetingRoomController.getMeetingRoom(widget.documentId);

    var data = _meetingRoom!.toJson();
    cepController.text = data['cep'] ?? '';
    logradouroController.text = data['endereco'] ?? '';
    numeroController.text = data['num_endereco'] ?? '';
    bairroController.text = data['bairro'] ?? '';
    complementoController.text = data['complemento'] ?? '';
    cidadeController.text = data['cidade'] ?? '';
    ufController.text = data['uf'] ?? '';
    tituloController.text = data['titulo'] ?? '';
    aberturaController.text = data['hr_abertura'] ?? '';
    fechamentoController.text = data['hr_fechamento'] ?? '';
    descricaoController.text = data['descricao'] ?? '';
    valorController.text = data['valor'] ?? '';
    capacidadeController.text = data['capacidade'] ?? '';
    acessibilidadeController.value = data['acessibilidade'] ?? false;
    arCondicionadoController.value = data['ar_condicionado'] ?? false;
    projetorController.value = data['projetor'] ?? false;
    quadroBrancoController.value = data['quadro_branco'] ?? false;
    tvController.value = data['tv'] ?? false;
    videoconferenciaController.value = data['videoconferencia'] ?? false;

    _pickedImagesWeb =
        await meetingRoomController.downloadImages(data['fotos']);

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
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Editar Sala de Reunião',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: tituloController,
                                  decoration: InputDecoration(
                                    labelText: 'Nome da Sala',
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
                                  controller: aberturaController,
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
                                  controller: fechamentoController,
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
                                flex: 1,
                                child: TextFormField(
                                  controller: valorController,
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
                              const SizedBox(width: 12.0),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: capacidadeController,
                                  decoration: InputDecoration(
                                    labelText: 'Capacidade',
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
                                  controller: cepController,
                                  inputFormatters: [cepFormat],
                                  onChanged: (cep) {
                                    if (cep.length == 9) {
                                      getAddress(cep).then((address) {
                                        setState(() {
                                          logradouroController.text =
                                              address['logradouro'] ?? '';
                                          cidadeController.text =
                                              address['localidade'] ?? '';
                                          ufController.text =
                                              address['uf'] ?? '';
                                          bairroController.text =
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
                              const SizedBox(width: 12.0),
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                  controller: logradouroController,
                                  enabled: cepController.text.isNotEmpty &&
                                          logradouroController.text.isEmpty
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
                              const SizedBox(width: 12.0),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: numeroController,
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
                                  controller: cidadeController,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: 'Cidade',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: ufController,
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
                                  controller: bairroController,
                                  enabled: cepController.text.isNotEmpty &&
                                          bairroController.text.isEmpty
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
                                  controller: complementoController,
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
                            controller: descricaoController,
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
                                                    Icons.ac_unit,
                                                    size: 20,
                                                  ),
                                                  Text(' Ar-Condicionado'),
                                                ],
                                              ),
                                              Switch(
                                                value: arCondicionadoController
                                                    .value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    arCondicionadoController
                                                        .value = value;
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
                                                    Icons.video_call,
                                                    size: 20,
                                                  ),
                                                  Text(' Vídeoconferência'),
                                                ],
                                              ),
                                              Switch(
                                                value:
                                                    videoconferenciaController
                                                        .value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    videoconferenciaController
                                                        .value = value;
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
                                                    Icons.wheelchair_pickup,
                                                    size: 20,
                                                  ),
                                                  Text(' Acessibilidade'),
                                                ],
                                              ),
                                              Switch(
                                                value: acessibilidadeController
                                                    .value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    acessibilidadeController
                                                        .value = value;
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
                                                    Icons.videogame_asset,
                                                    size: 20,
                                                  ),
                                                  Text(' Projetor'),
                                                ],
                                              ),
                                              Switch(
                                                value: projetorController.value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    projetorController.value =
                                                        value;
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
                                                    Icons.developer_board,
                                                    size: 20,
                                                  ),
                                                  Text(' Quadro Branco'),
                                                ],
                                              ),
                                              Switch(
                                                value: quadroBrancoController
                                                    .value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    quadroBrancoController
                                                        .value = value;
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
                                                    Icons.tv,
                                                    size: 20,
                                                  ),
                                                  Text(' TV'),
                                                ],
                                              ),
                                              Switch(
                                                value: tvController.value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    tvController.value = value;
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
                                                        BorderRadius.circular(
                                                            4),
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
                              onPressed: () {
                                if (tituloController.text.isNotEmpty &&
                                    aberturaController.text.isNotEmpty &&
                                    fechamentoController.text.isNotEmpty &&
                                    descricaoController.text.isNotEmpty &&
                                    valorController.text.isNotEmpty &&
                                    capacidadeController.text.isNotEmpty &&
                                    cepController.text.isNotEmpty &&
                                    logradouroController.text.isNotEmpty &&
                                    numeroController.text.isNotEmpty &&
                                    bairroController.text.isNotEmpty &&
                                    cidadeController.text.isNotEmpty &&
                                    ufController.text.isNotEmpty) {
                                  var meetingRoomController =
                                      MeetingRoomController();

                                  var meetingRoomAtualizado =
                                      _meetingRoom!.copyWith(
                                    titulo: tituloController.text,
                                    valor: valorController.text,
                                    capacidade: capacidadeController.text,
                                    cep: cepController.text,
                                    endereco: logradouroController.text,
                                    num_endereco: numeroController.text,
                                    cidade: cidadeController.text,
                                    uf: ufController.text,
                                    bairro: bairroController.text,
                                    complemento: complementoController.text,
                                    descricao: descricaoController.text,
                                    ar_condicionado:
                                        arCondicionadoController.value,
                                    acessibilidade:
                                        acessibilidadeController.value,
                                    projetor: projetorController.value,
                                    tv: tvController.value,
                                    videoconferencia:
                                        videoconferenciaController.value,
                                    quadro_branco: quadroBrancoController.value,
                                    hr_abertura: aberturaController.text,
                                    hr_fechamento: fechamentoController.text,
                                  );

                                  meetingRoomController.updateMeetingRoom(
                                      widget.documentId,
                                      meetingRoomAtualizado,
                                      _pickedImagesWeb,
                                      context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          'Preencha todos os campos obrigatórios.'),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'EDITAR',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(177, 47, 47, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ))
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
          )),
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
