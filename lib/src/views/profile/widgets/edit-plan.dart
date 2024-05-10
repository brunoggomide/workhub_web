import 'package:flutter/material.dart';

import '../../../controllers/auth/auth_controller.dart';
import '../../../controllers/user/user_controller.dart';
import '../../../models/user_model.dart';

class EditPlan extends StatelessWidget {
  const EditPlan({
    Key? key,
    required this.item,
    required this.id,
    required this.numDesk,
    required this.numMeet,
  }) : super(key: key);

  final dynamic item;
  final String id;
  final int numDesk, numMeet;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: Stack(alignment: Alignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPlanSection('PLANOS MENSAIS'),
                _buildPlanRow(context, isAnnual: false),
                SizedBox(height: 16.0),
                _buildPlanSection('PLANOS ANUAIS'),
                _buildPlanRow(context, isAnnual: true),
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
              icon: const Icon(Icons.close),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildPlanRow(BuildContext context, {required bool isAnnual}) {
    List<Map<String, dynamic>> plans = [
      {
        'name': 'Basic',
        'price': isAnnual ? '10x de R\$ 69,90' : 'R\$ 69,90 por mês',
        'meet': '5 salas de reuniões',
        'desk': '10 posições de trabalho',
        'deskNum': 10,
        'meetNum': 5,
      },
      {
        'name': 'Plus',
        'price': isAnnual ? '10x de R\$ 74,90' : 'R\$ 74,90 por mês',
        'meet': '10 salas de reuniões',
        'desk': '20 posições de trabalho',
        'deskNum': 20,
        'meetNum': 10,
      },
      {
        'name': 'Premium',
        'price': isAnnual ? '10x de R\$ 79,90' : 'R\$ 79,90 por mês',
        'meet': 'Salas de reuniões ilimitadas',
        'desk': 'Posições de trabalho ilimitadas',
        'deskNum': 5000,
        'meetNum': 5000,
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          plans.where((plan) => plan['name'] != item['plano']).map((plan) {
        return _buildPlanCard(
          plan['name'],
          plan['price'],
          plan['meet'],
          plan['desk'],
          () {
            if (plan['deskNum'] < numDesk) {
            } else if (plan['meetNum'] < numMeet) {
            } else {
              var e = UsuarioModel(
                AuthController().idUsuario(),
                item['nome'],
                item['contato'],
                plan['name'],
                plan['deskNum'],
                plan['meetNum'],
                '',
              );

              UserController().atualizar(context, id, e);
              Navigator.of(context).pop();
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildPlanCard(
    String name,
    String price,
    String feature1,
    String feature2,
    VoidCallback onPressed,
  ) {
    return Card(
      elevation: 3.0,
      child: Container(
        height: 200,
        width: 250,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                price,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(feature1),
              Text(feature2),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: onPressed,
                child: Text('Mudar Plano'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
