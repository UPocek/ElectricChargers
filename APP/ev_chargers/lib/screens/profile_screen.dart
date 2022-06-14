import 'dart:io';
import 'package:ev_chargers/screens/prepaid_screen.dart';
import 'package:ev_chargers/style.dart';
import 'package:ev_chargers/widgets/google_maps.dart';
import 'package:ev_chargers/widgets/padding_card.dart';
import 'package:flutter/material.dart';
import '../helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

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
              LastFiveWindow(),
              StatisticWindow(),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
  }
}

class MapWindow extends StatelessWidget {
  final LatLng? userPosition;
  const MapWindow(this.userPosition, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PaddingCard(
      SizedBox(
        height: 300.0,
        child: MapWidget(
          LatLng(0, 0),
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

class LastFiveWindow extends StatelessWidget {
  const LastFiveWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class StatisticWindow extends StatelessWidget {
  const StatisticWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
