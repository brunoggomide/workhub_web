import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workhub_web/src/views/desks/newDesk.dart';

import '../../controllers/desks/desk_controller.dart';
import '../../models/desk_model.dart';

class Desks extends StatelessWidget {
  final DeskController meetingRoomController = DeskController();

  Desks({Key? key}) : super(key: key);

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
                            return const NewDesk();
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
                    StreamBuilder<List<Desk>>(
                      stream: meetingRoomController.listar(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Desk>> snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
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
                                    'Título da mesa',
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
                              rows: snapshot.data!.map((Desk desk) {
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(desk.titulo)),
                                    DataCell(Text("R\$${desk.valor}")),
                                    DataCell(Text(desk.endereco)),
                                    DataCell(Text(desk.hr_abertura)),
                                    DataCell(Text(desk.hr_fechamento)),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
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
