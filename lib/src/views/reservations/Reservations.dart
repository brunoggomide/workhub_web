import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/booking/booking_dao.dart';
import '../../controllers/meeting_room/meeting_room_controller.dart';

class Reservations extends StatefulWidget {
  Reservations({Key? key}) : super(key: key);

  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  final MeetingRoomController meetingRoomController = MeetingRoomController();
  final BookingDao bookingDao = BookingDao();
  String? selectedDate;

  DateTime _parseDate(String dateString) {
    final List<String> parts = dateString.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  void _clearFilters() {
    setState(() {
      selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RawMaterialButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 30)),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                        });
                      }
                    },
                    fillColor: const Color.fromARGB(255, 232, 236, 239),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 2.0,
                    padding: const EdgeInsets.all(12.0),
                    child: const Icon(
                      Icons.calendar_month,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RawMaterialButton(
                    onPressed: _clearFilters,
                    fillColor: const Color.fromARGB(255, 232, 236, 239),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 2.0,
                    padding: const EdgeInsets.all(12.0),
                    child: const Text('Limpar filtros'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: selectedDate == null
                            ? bookingDao
                                .listarConfirmados(AuthController().idUsuario())
                            : bookingDao.listarPorDia(
                                AuthController().idUsuario(), selectedDate!),
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

                          if (snapshot.data != null &&
                              snapshot.data!.docs.isNotEmpty) {
                            final List<DocumentSnapshot> documents =
                                snapshot.data!.docs;
                            documents.sort((a, b) {
                              DateTime dateA = _parseDate(a.get('data'));
                              DateTime dateB = _parseDate(b.get('data'));
                              return dateA.compareTo(dateB);
                            });

                            return DataTable(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color.fromARGB(255, 243, 246, 248),
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
                                            fontStyle: FontStyle.italic))),
                                DataColumn(
                                    label: Text('Data | Horário',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic))),
                                DataColumn(
                                    label: Text('E-Mail Usuário',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic))),
                                DataColumn(
                                    label: Text('Contato Usuário',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic))),
                                DataColumn(
                                    label: Text('Valor',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic))),
                                DataColumn(
                                    label: Text('Pagamento',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic))),
                              ],
                              rows: documents.map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
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
                                        future: BookingDao.getEmailByUid(
                                            data['uid_cliente']),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String?> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return Text(
                                                snapshot.data ?? 'Unavailable');
                                          } else {
                                            return Text('Loading...');
                                          }
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      FutureBuilder<String?>(
                                        future: BookingDao.getNumberByUid(
                                            data['uid_cliente']),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String?> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return Text(
                                                snapshot.data ?? 'Unavailable');
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
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'NÃO POSSUI RESERVAS',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            );
                          }
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
