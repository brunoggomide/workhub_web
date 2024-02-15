import 'package:flutter/material.dart';

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
  final TextEditingController uidCoworkingController = TextEditingController();

  final ValueNotifier<bool> acessibilidadeController =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> arCondicionadoController =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> projetorController = ValueNotifier<bool>(false);
  final ValueNotifier<bool> quadroBrancoController = ValueNotifier<bool>(false);
  final ValueNotifier<bool> tvController = ValueNotifier<bool>(false);

  //var foto;

  DateTime? dtCriacao;
  DateTime? dtAtualizacao;

  List<String> ufs = ['SP', 'RJ', 'MG', 'ES']; // Lista de UFs

  @override
  void initState() {
    super.initState();
    selectedUf = ufs[0]; // Inicialize selectedUf aqui
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
    uidCoworkingController.dispose();

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
            const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CEP'),
                      TextField(
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
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Foto'),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey,
                        child: const Icon(
                          Icons.camera_alt,
                          size: 50,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(110, 40)),
                  ),
                  onPressed: () {},
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
}
