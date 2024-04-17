import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workhub_web/src/views/auth/signUp/signUpPage.dart';
import 'package:workhub_web/src/views/utils/background.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({Key? key}) : super(key: key);

  static Future<String?> getPlanName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('planName');
  }

  static Future<int?> getMeetingRooms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('meetingRooms');
  }

  static Future<int?> getWorkPositions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('workPositions');
  }

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  Future<void> savePlanData(
      String planName, int meetingRooms, int workPositions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('planName', planName);
    prefs.setInt('meetingRooms', meetingRooms);
    prefs.setInt('workPositions', workPositions);
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPlanSection('PLANOS MENSAIS'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPlanCard(
                  'Basic',
                  'R\$ 39,90 por mês',
                  '5 salas de reuniões',
                  '10 posições de trabalho',
                  () {
                    savePlanData('Basic', 5, 10);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) {
                          return SignUpPage();
                        },
                      ),
                    );
                    print('Botão Basic Mensal pressionado');
                  },
                ),
                _buildPlanCard(
                  'Plus',
                  'R\$ 45,90 por mês',
                  '10 salas de reuniões',
                  '20 posições de trabalho',
                  () {
                    savePlanData('Plus', 10, 20);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) {
                          return SignUpPage();
                        },
                      ),
                    );
                    print('Botão Plus Mensal pressionado');
                  },
                ),
                _buildPlanCard(
                  'Premium',
                  'R\$ 49,90 por mês',
                  'Salas de reuniões ilimitadas',
                  'Posições de trabalho ilimitadas',
                  () {
                    savePlanData('Premium', 10000, 10000);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) {
                          return SignUpPage();
                        },
                      ),
                    );
                    print('Botão Premium Mensal pressionado');
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            _buildPlanSection('PLANOS ANUAIS'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPlanCard(
                  'Basic',
                  '10x de R\$ 39,90',
                  '5 salas de reuniões',
                  '10 posições de trabalho',
                  () {
                    savePlanData('Basic', 5, 10);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) {
                          return SignUpPage();
                        },
                      ),
                    );
                    print('Botão Basic anual pressionado');
                  },
                ),
                _buildPlanCard(
                  'Plus',
                  '10x de R\$ 45,90',
                  '10 salas de reuniões',
                  '20 posições de trabalho',
                  () {
                    savePlanData('Plus', 10, 20);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) {
                          return SignUpPage();
                        },
                      ),
                    );
                    print('Botão Plus anual pressionado');
                  },
                ),
                _buildPlanCard(
                  'Premium',
                  '10x de R\$ 49,90',
                  'Salas de reuniões ilimitadas',
                  'Posições de trabalho ilimitadas',
                  () {
                    savePlanData('Premium', 10000, 10000);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) {
                          return SignUpPage();
                        },
                      ),
                    );
                    print('Botão Premium Anual pressionado');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
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
                child: Text('Comece agora'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(177, 47, 47, 1),
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
