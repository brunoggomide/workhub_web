import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workhub_web/src/controllers/auth/auth_controller.dart';

import '../../controllers/meeting_room/meeting_room_controller.dart';
import '../../controllers/booking/booking_dao.dart'; // Ensure you have imported correctly

class Reservations extends StatelessWidget {
  final MeetingRoomController meetingRoomController = MeetingRoomController();
  final BookingDao bookingDao =
      BookingDao(); // Create an instance of BookingDao

  Reservations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RawMaterialButton(
                  onPressed: () {
                    // Implement your dialog opening logic here
                  },
                  fillColor: const Color.fromARGB(255, 232, 236, 239),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 2.0,
                  padding: const EdgeInsets.all(12.0),
                  child: const Icon(
                    Icons.filter_alt,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: bookingDao
                            .listarConfirmados(AuthController().idUsuario()),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text(
                              'Algo deu errado',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              "Carregando informações",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }

                          // Extrair documentos do snapshot
                          final List<DocumentSnapshot> documents =
                              snapshot.data!.docs;

                          // Função para converter string de data no formato brasileiro para DateTime
                          DateTime _parseBrazilianDate(String dateString) {
                            final List<String> parts = dateString.split('/');
                            if (parts.length != 3) {
                              throw Exception(
                                  'Formato de data inválido: $dateString');
                            }
                            final int day = int.parse(parts[0]);
                            final int month = int.parse(parts[1]);
                            final int year = int.parse(parts[2]);
                            return DateTime(year, month, day);
                          }

                          // Ordenar documentos com base na data
                          documents.sort((a, b) {
                            final DateTime dateA =
                                _parseBrazilianDate(a['data']);
                            final DateTime dateB =
                                _parseBrazilianDate(b['data']);
                            return dateA.compareTo(dateB);
                          });

                          return Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color:
                                      const Color.fromARGB(255, 243, 246, 248),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(0.0, 0.0),
                                    ),
                                  ],
                                ),
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text('Local',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ),
                                  DataColumn(
                                    label: Text('Data | Horário',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ),
                                  DataColumn(
                                    label: Text('E-Mail Usuário',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ),
                                  DataColumn(
                                    label: Text('Contato Usuário',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ),
                                  DataColumn(
                                    label: Text('Valor',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ),
                                  DataColumn(
                                    label: Text('Pagamento',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ),
                                ],
                                rows:
                                    documents.map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data() as Map<String, dynamic>;
                                  return DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(data['local'] ?? '')),
                                      DataCell(Text(data['data'] +
                                              ' | ' +
                                              data['inicio'] +
                                              ' - ' +
                                              data['fim'] ??
                                          '')),
                                      DataCell(
                                        FutureBuilder<String?>(
                                          future: AuthController.getEmailByUid(
                                              data['uid_cliente']),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<String?> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return Text(snapshot.data ??
                                                  'Unavailable');
                                            } else {
                                              return Text('Loading...');
                                            }
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        FutureBuilder<String?>(
                                          future: AuthController.getNumberByUid(
                                              data['uid_cliente']),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<String?> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return Text(snapshot.data ??
                                                  'Unavailable');
                                            } else {
                                              return Text('Loading...');
                                            }
                                          },
                                        ),
                                      ),
                                      DataCell(Text(data['valor'] ?? '')),
                                      DataCell(Text(data['pagamento'] ?? '')),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
