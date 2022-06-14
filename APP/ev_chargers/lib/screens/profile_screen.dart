import 'package:ev_chargers/screens/prepaid_screen.dart';
import 'package:ev_chargers/style.dart';
import 'package:ev_chargers/widgets/google_maps.dart';
import 'package:ev_chargers/widgets/padding_card.dart';
import 'package:flutter/material.dart';
import '../helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../models/transaction.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double? accountBalance;
  LatLng? userPosition;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  getUserLocation() async {
    Position? position = await _determinePosition();
    setState(() {
      userPosition = LatLng(position.latitude, position.longitude);
    });
  }

  getUserBalance() {
    setState(() {
      accountBalance = user?.accountBalance;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
    getUserBalance();
  }

  @override
  Widget build(BuildContext context) {
    return userPosition != null && accountBalance != null
        ? ListView(
            children: [
              MapWindow(userPosition),
              BalanceWindow(accountBalance ?? 0.0),
              const LastFiveWindow(),
              const StatisticWindow(),
              ElevatedButton(onPressed: _tagRead, child: Icon(Icons.start)),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
  }

  void _tagRead() {
    NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443, NfcPollingOption.iso15693},
      onDiscovered: (NfcTag tag) async {
        print(tag.data['mifare']['identifier'].toString());
        NfcManager.instance.stopSession();
      },
    );
  }
}

class MapWindow extends StatelessWidget {
  final LatLng? userPosition;
  const MapWindow(this.userPosition, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaddingCard(
      SizedBox(
        height: 300.0,
        child: GestureDetector(
          onTap: () => {},
          child: MapWidget(
            userPosition ?? const LatLng(0, 0),
          ),
        ),
      ),
    );
  }
}

class BalanceWindow extends StatelessWidget {
  final double balance;
  const BalanceWindow(this.balance, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaddingCard(
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "Your balance",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: mediumTextSize,
                    fontWeight: FontWeight.w500,
                    fontFamily: fontName),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                '\$$balance',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: fontName,
                  fontSize: hugeFontSize,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 165.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                      ),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrepaidScreen(),
                      ),
                    ),
                    child: const Text('Transfer Money'),
                  ),
                ),
                SizedBox(
                  width: 165.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                      ),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrepaidScreen(),
                      ),
                    ),
                    child: const Text('See benefits'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(220, 20, 20, 20),
    );
  }
}

class LastFiveWindow extends StatefulWidget {
  const LastFiveWindow({Key? key}) : super(key: key);

  @override
  State<LastFiveWindow> createState() => _LastFiveWindowState();
}

class _LastFiveWindowState extends State<LastFiveWindow> {
  List<Transaction>? userLastFive;

  getUserTransactions() async {
    userLastFive = await Transaction.getLastFive();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return PaddingCard(
      DataTable(
        columns: const [
          DataColumn(
              label: Text('Date',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Station',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Price',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('kWh',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
        ],
        rows: fillRows(
          userLastFive ?? [],
        ),
      ),
    );
  }

  List<DataRow> fillRows(List<Transaction> userLastFive) {
    return userLastFive
        .map(
          (e) => DataRow(
            cells: [
              DataCell(Text(
                e.transactionDate,
                style: TextStyle(fontSize: 12.0),
              )),
              DataCell(
                Text(
                  e.station,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              DataCell(Text(
                e.price.toString(),
                style: TextStyle(fontSize: 12.0),
              )),
              DataCell(Text(
                e.kwh.toString(),
                style: TextStyle(fontSize: 12.0),
              )),
            ],
          ),
        )
        .toList();
  }
}

class StatisticWindow extends StatefulWidget {
  const StatisticWindow({Key? key}) : super(key: key);

  @override
  State<StatisticWindow> createState() => _StatisticWindowState();
}

class _StatisticWindowState extends State<StatisticWindow> {
  double kwhUsed = 0.0;

  getUserTransactions() async {
    kwhUsed = await Transaction.getStats();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return PaddingCard(
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "kWh Used",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: mediumTextSize,
                    fontWeight: FontWeight.w500,
                    fontFamily: fontName),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                '$kwhUsed',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: fontName,
                  fontSize: hugeFontSize,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.amber,
    );
  }
}
