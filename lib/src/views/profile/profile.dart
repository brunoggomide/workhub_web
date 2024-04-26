import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workhub_web/src/views/profile/widgets/edit-password.dart';
import 'package:workhub_web/src/views/profile/widgets/edit-profile.dart';

import '../../controllers/user/user_controller.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: UserController().getData().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text('Não foi possível conectar.'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final dados = snapshot.requireData;
            dynamic item = dados.docs[0].data();
            String id = dados.docs[0].id;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['nome'],
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text(item['email'], style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Text(item['contato'], style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Text(item['documento'], style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Text('Plano ' + item['plano'],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Expanded(
                      child:
                          Container()), // This will push the footer to the bottom
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => EditProfile(
                                    item: item,
                                    id: id,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.grey[850], // Cor do botão
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical:
                                        20), // Aumenta o padding para aumentar o botão
                              ),
                              child: const Text('Editar Perfil'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => EditPassword(
                                    email: item['email'],
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.grey[850], // Cor do botão
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical:
                                        20), // Aumenta o padding para aumentar o botão
                              ),
                              child: const Text('Editar Senha'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.grey[850], // Cor do botão
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical:
                                        20), // Aumenta o padding para aumentar o botão
                              ),
                              child: const Text('Mudar Plano'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    item['planoDesk'].toString() == '5000'
                                        ? '10/Ilimitado'
                                        : '10/' + item['planoDesk'].toString(),
                                    style: TextStyle(fontSize: 20)),
                                Text('Mesas', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(
                                width:
                                    24), // Espaçamento entre 'Mesas' e 'Salas'
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    item['planoMeet'].toString() == '5000'
                                        ? '4/Ilimitado'
                                        : '4/' + item['planoMeet'].toString(),
                                    style: TextStyle(fontSize: 20)),
                                Text('Salas', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
