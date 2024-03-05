import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controllers/meeting_room/meeting_room_controller.dart';

class AddMeetingRoomForm extends StatefulWidget {
  const AddMeetingRoomForm({Key? key}) : super(key: key);

  @override
  State<AddMeetingRoomForm> createState() => _AddMeetingRoomFormState();
}

class _AddMeetingRoomFormState extends State<AddMeetingRoomForm> {
  final TextEditingController cepController = TextEditingController();
  final TextEditingController logradouroController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();
  late String selectedUf;
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController capacidadeController = TextEditingController();

  final ValueNotifier<bool> acessibilidadeController =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> arCondicionadoController =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> projetorController = ValueNotifier<bool>(false);
  final ValueNotifier<bool> quadroBrancoController = ValueNotifier<bool>(false);
  final ValueNotifier<bool> tvController = ValueNotifier<bool>(false);

  File? _pickedImage;
  Uint8List? _pickedImageWeb;
  List<File> _pickedImages = [];
  List<Uint8List> _pickedImagesWeb = [];

  DateTime? dtCriacao;

  List<String> ufs = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ]; // Lista de UFs

  @override
  void initState() {
    super.initState();
    selectedUf = ufs[0];
  }

  @override
  void dispose() {
    cepController.dispose();
    logradouroController.dispose();
    numeroController.dispose();
    bairroController.dispose();
    complementoController.dispose();
    cidadeController.dispose();
    tituloController.dispose();
    descricaoController.dispose();
    valorController.dispose();
    capacidadeController.dispose();

    acessibilidadeController.dispose();
    arCondicionadoController.dispose();
    projetorController.dispose();
    quadroBrancoController.dispose();
    tvController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[50]),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CEP'),
                      TextField(
                        controller: cepController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Logradouro'),
                      TextField(
                        controller: logradouroController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Número'),
                      TextField(
                        controller: numeroController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bairro'),
                      TextField(
                        controller: bairroController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Complemento'),
                      TextField(
                        controller: complementoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('UF'),
                      DropdownButton<String>(
                        hint: Text('Selecione a UF'),
                        value: selectedUf,
                        onChanged: (String? value) {
                          setState(() {
                            selectedUf = value ?? '';
                          });
                        },
                        items:
                            ufs.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cidade'),
                      TextField(
                        controller: cidadeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Título da sala'),
                      TextField(
                        controller: tituloController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Descrição'),
                      TextField(
                        controller: descricaoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Valor da hora'),
                      TextField(
                        controller: valorController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Capacidade'),
                      TextField(
                        controller: capacidadeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recursos da sala'),
                      Row(
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: acessibilidadeController,
                            builder: (context, value, child) {
                              return Checkbox(
                                value: value,
                                onChanged: (bool? value) {
                                  acessibilidadeController.value =
                                      value ?? false;
                                },
                              );
                            },
                          ),
                          Text('Acessibilidade'),
                        ],
                      ),
                      Row(
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: arCondicionadoController,
                            builder: (context, value, child) {
                              return Checkbox(
                                value: value,
                                onChanged: (bool? value) {
                                  arCondicionadoController.value =
                                      value ?? false;
                                },
                              );
                            },
                          ),
                          Text('Ar Condicionado'),
                        ],
                      ),
                      Row(
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: projetorController,
                            builder: (context, value, child) {
                              return Checkbox(
                                value: value,
                                onChanged: (bool? value) {
                                  projetorController.value = value ?? false;
                                },
                              );
                            },
                          ),
                          Text('Projetor'),
                        ],
                      ),
                      Row(
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: quadroBrancoController,
                            builder: (context, value, child) {
                              return Checkbox(
                                value: value,
                                onChanged: (bool? value) {
                                  quadroBrancoController.value = value ?? false;
                                },
                              );
                            },
                          ),
                          Text('Quadro Branco'),
                        ],
                      ),
                      Row(
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: tvController,
                            builder: (context, value, child) {
                              return Checkbox(
                                value: value,
                                onChanged: (bool? value) {
                                  tvController.value = value ?? false;
                                },
                              );
                            },
                          ),
                          Text('TV'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey),
                            fixedSize: MaterialStateProperty.all(const Size(200, 40)),
                          ),
                          onPressed: () => _pickImage(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget> [
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
                          children:
                              _pickedImagesWeb.asMap().entries.map((entry) {
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
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        _pickedImagesWeb.removeAt(index);
                                        _pickedImages.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(110, 40)),
                  ),
                  onPressed: () {
                    String cep = cepController.text;
                    String logradouro = logradouroController.text;
                    String numero = numeroController.text;
                    String bairro = bairroController.text;
                    String complemento = complementoController.text;
                    String uf = selectedUf;
                    String cidade = cidadeController.text;
                    String titulo = tituloController.text;
                    String descricao = descricaoController.text;
                    double valor = double.parse(valorController.text);
                    int capacidade = int.parse(capacidadeController.text);
                    bool acessibilidade = acessibilidadeController.value;
                    bool arCondicionado = arCondicionadoController.value;
                    bool projetor = projetorController.value;
                    bool quadroBranco = quadroBrancoController.value;
                    bool tv = tvController.value;
                    DateTime dtCriacao = DateTime.now();
                    if (cep.isNotEmpty &&
                        logradouro.isNotEmpty &&
                        numero.isNotEmpty &&
                        bairro.isNotEmpty &&
                        uf.isNotEmpty &&
                        cidade.isNotEmpty &&
                        titulo.isNotEmpty &&
                        descricao.isNotEmpty &&
                        valor.isFinite &&
                        capacidade.isFinite) {
                      MeetingRoomController().addMeetingRoom(
                          cep,
                          logradouro,
                          numero,
                          bairro,
                          complemento,
                          uf,
                          cidade,
                          titulo,
                          descricao,
                          valor,
                          capacidade,
                          acessibilidade,
                          arCondicionado,
                          projetor,
                          quadroBranco,
                          tv,
                          dtCriacao,
                          _pickedImagesWeb);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content:
                              Text('Preencha todos os campos obrigatórios.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Adicionar'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    fixedSize: MaterialStateProperty.all(const Size(100, 40)),
                  ),
                  onPressed: () {}, //=> pageController.jumpToPage(1),
                  child: const Text('Voltar'),
                ),
              ],
            ),
          ],
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
