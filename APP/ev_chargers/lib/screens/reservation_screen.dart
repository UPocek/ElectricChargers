import 'package:flutter/material.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      const SizedBox(
        height: 20.0,
      ),
      DataTable(
        columns: const [
          DataColumn(
              label: Text('DateTime',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Station',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Cancel',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('1')),
            DataCell(Text('Stephen')),
            DataCell(
              IconButton(
                onPressed: () => cancelReservation('1'),
                icon: const Icon(Icons.cancel, color: Colors.redAccent),
              ),
            ),
          ]),
          DataRow(cells: [
            DataCell(Text('5')),
            DataCell(Text('John')),
            DataCell(
              IconButton(
                onPressed: () => cancelReservation('1'),
                icon: const Icon(Icons.cancel, color: Colors.redAccent),
              ),
            ),
          ]),
          DataRow(cells: [
            DataCell(Text('10')),
            DataCell(Text('Harry')),
            DataCell(
              IconButton(
                onPressed: () => cancelReservation('1'),
                icon: const Icon(Icons.cancel, color: Colors.redAccent),
              ),
            ),
          ]),
          DataRow(cells: [
            DataCell(Text('15')),
            DataCell(Text('Peter')),
            DataCell(
              IconButton(
                onPressed: () => cancelReservation('1'),
                icon: const Icon(Icons.cancel, color: Colors.redAccent),
              ),
            ),
          ]),
        ],
      ),
    ]));
  }

  cancelReservation(String id) {}
}
