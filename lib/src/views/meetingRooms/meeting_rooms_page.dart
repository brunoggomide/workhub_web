import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../controllers/meeting_room/meeting_room_controller.dart';
import 'addMeetingRooms/components/add_meeting_room_form.dart';
import 'addMeetingRooms/components/edit_meeting_room_form.dart';

class MeetingRoomsPage extends StatelessWidget {
  final MeetingRoomController meetingRoomController = MeetingRoomController();

  MeetingRoomsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return const AddMeetingRoomForm();
                          });
                    },
                    fillColor: const Color.fromARGB(255, 232, 236, 239),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 2.0,
                    padding: const EdgeInsets.all(12.0),
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: meetingRoomController.getMeetingRooms(),
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

                        return Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
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
                              columns: <DataColumn>[
                                const DataColumn(
                                  label: Text(
                                    'Título da sala',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    'Valor da hora',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    'Endereço',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    'Abertura',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    'Fechamento',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    width: 0.2,
                                    child: const Text(''),
                                  ),
                                )
                              ],
                              rows: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data() as Map<String, dynamic>;
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(data['titulo'] ?? '')),
                                    DataCell(Text("R\$${data['valor']}")),
                                    DataCell(Text(data['endereco'] ?? '')),
                                    DataCell(Text(data['hr_abertura'] ?? '')),
                                    DataCell(Text(data['hr_fechamento'] ?? '')),
                                    DataCell(
                                      Container(
                                        width: 100,
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (_) {
                                                      print(
                                                          "page: id meeting room - ${document.id}");
                                                      return EditMeetingRoomForm(
                                                        documentId: document.id,
                                                      );
                                                    });
                                              },
                                            ),
                                            IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Excluir sala de reunião'),
                                                        content: const Text(
                                                            'Tem certeza que deseja excluir essa sala de reunião?'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              meetingRoomController
                                                                  .deleteMeetingRoom(
                                                                data[
                                                                    'UID_coworking'],
                                                                document.id,
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Sim'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Não'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  color: snapshot.data!.docs
                                          .indexOf(document
                                              as QueryDocumentSnapshot<Object?>)
                                          .isEven
                                      ? MaterialStateProperty.all(
                                          Colors.grey.shade100)
                                      : null,
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
