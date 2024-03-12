import 'package:flutter/material.dart';

class ReservationsPage extends StatelessWidget {
  final PageController pageController;

  const ReservationsPage({Key? key, required this.pageController})
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
                icon: const Icon(Icons.calendar_month_outlined),
                iconSize: 36.0,
                onPressed: () => pageController.jumpToPage(4),
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
                        'Local',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Data',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Usuário',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Valor',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  rows: const [
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Mesa 13')),
                        DataCell(Text('12/12/2021')),
                        DataCell(Text('João da Silva')),
                        DataCell(Text('R\$ 70,00')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Mesa 12')),
                        DataCell(Text('12/12/2021')),
                        DataCell(Text('João da Silva')),
                        DataCell(Text('R\$ 50,00')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Mesa 15')),
                        DataCell(Text('12/12/2021')),
                        DataCell(Text('João da Silva')),
                        DataCell(Text('R\$ 80,00')),
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

/* Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                iconSize: 36.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalendarPage(),
                    ),
                  );
                },
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('reservations')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              return DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Mesa'),
                  ),
                  DataColumn(
                    label: Text('Data'),
                  ),
                  DataColumn(
                    label: Text('Nome'),
                  ),
                  DataColumn(
                    label: Text('Preço'),
                  ),
                ],
                rows: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Text(data['table'].toString())),
                      DataCell(Text(data['date'].toDate().toString())),
                      DataCell(Text(data['name'])),
                      DataCell(Text('R\$ ' + data['price'].toString())),
                    ],
                  );
                }).toList(),
              );
            },
          )
        ],
      ),
    );
  } 
  */