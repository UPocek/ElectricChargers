import 'package:flutter/material.dart';

import '../models/reservation.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  List<Reservation>? allUserReservations;

  getAllReservations() async {
    allUserReservations = await Reservation.getAll();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          DataTable(columns: const [
            DataColumn(
                label: Text('DateTime',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Charger',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Cancel',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          ], rows: fillRows(allUserReservations ?? [])),
        ],
      ),
    );
  }

  List<DataRow> fillRows(List<Reservation> allUserReservations) {
    return allUserReservations
        .map(
          (e) => DataRow(
            cells: [
              DataCell(Text(e.reservationDateTime)),
              DataCell(Text(e.charger)),
              DataCell(
                IconButton(
                  onPressed: () => cancelReservation(e.stationId),
                  icon: const Icon(Icons.cancel, color: Colors.redAccent),
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  cancelReservation(String id) async {
    if (!await Reservation.cancelReservation(id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cancellation failed. Try again later."),
        ),
      );
    } else {
      getAllReservations();
    }
  }
}
