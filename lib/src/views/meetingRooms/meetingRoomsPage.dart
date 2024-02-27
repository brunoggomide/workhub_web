import 'package:flutter/material.dart';

class MeetingRoomsPage extends StatelessWidget {
  final PageController pageController;

  const MeetingRoomsPage({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.add_box_outlined),
                iconSize: 36.0,
                onPressed: () => pageController.jumpToPage(5),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Título da Sala',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Recursos da Sala',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Valor da Hora',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Editar',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Sala 1')),
                        DataCell(Text('Projetor, TV, Ar Condicionado')),
                        DataCell(Text('R\$ 50,00')),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Sala 2')),
                        DataCell(Text('Projetor, TV, Ar Condicionado')),
                        DataCell(Text('R\$ 50,00')),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Sala 3')),
                        DataCell(Text('Projetor, TV, Ar Condicionado')),
                        DataCell(Text('R\$ 50,00')),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
