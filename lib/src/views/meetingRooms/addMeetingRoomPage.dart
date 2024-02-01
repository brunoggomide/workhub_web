import 'package:flutter/material.dart';

class AddMeetingRoomPage extends StatelessWidget {
  final PageController pageController;

  const AddMeetingRoomPage({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tela em desenvolvimento
    return Scaffold(
      body: Column(
        children: [
          const Text('Adicionar Sala de Reunião'),
          const Text('Título da Sala'),
          const TextField(),
          const Text('Recursos da Sala'),
          const TextField(),
          const Text('Valor da Hora'),
          const TextField(),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Adicionar'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
            ),
            onPressed: () => pageController.jumpToPage(1),
            child: const Text('Voltar'),
          ),
        ],
      ),
    );
  }
}
