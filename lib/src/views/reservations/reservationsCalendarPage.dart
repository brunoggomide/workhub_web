import 'package:flutter/material.dart';

class ReservationsCalendarPage extends StatelessWidget {
  final PageController pageController;

  const ReservationsCalendarPage({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tela em desenvolvimento
    return Scaffold(
      body: Column(
        children: [
          const Text('Calendario de reservas'),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
            ),
            onPressed: () => pageController.jumpToPage(0),
            child: const Text('Voltar'),
          ),
        ],
      ),
    );
  }
}
