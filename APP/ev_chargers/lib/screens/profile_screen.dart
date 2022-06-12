import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double? accountBalance;

  @override
  void initState() {
    super.initState();
    getAccountBalance();
  }

  getAccountBalance() async {
    setState(() {
      // accountBalance = await User.getBalance();
      accountBalance = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        MapWindow(),
        BalanceWindow(),
        LastFiveWindow(),
        StatisticWindow(),
      ],
    ));
  }
}

class MapWindow extends StatelessWidget {
  const MapWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BalanceWindow extends StatelessWidget {
  const BalanceWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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
