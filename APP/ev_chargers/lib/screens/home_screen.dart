import 'package:ev_chargers/screens/charging_screen.dart';
import 'package:ev_chargers/style.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'map_screen.dart';
import 'reservation_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const List<Tab> navigationTabs = <Tab>[
    Tab(icon: Icon(Icons.person_outline)),
    Tab(icon: Icon(Icons.calendar_today_outlined)),
    Tab(icon: Icon(Icons.map_outlined)),
    Tab(icon: Icon(Icons.settings_outlined)),
  ];
  List<Widget> pages = const [
    ProfileScreen(),
    ReservationScreen(),
    MapScreen(),
    SettingsScreen()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: navigationTabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        elevation: 5,
        toolbarHeight: 80,
        title: const Text("EV chargers"),
        titleTextStyle: titleTextStyle,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.white, blurStyle: BlurStyle.inner),
          ],
        ),
        child: TabBar(
          padding: const EdgeInsets.all(25.0),
          controller: _tabController,
          tabs: navigationTabs,
          splashFactory: NoSplash.splashFactory,
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return states.contains(MaterialState.focused)
                ? null
                : Colors.transparent;
          }),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChargingScreen('1'),
            ),
          )
        },
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.bolt,
          color: Colors.white,
        ),
      ),
    );
  }
}

class NoMoneyAlert extends StatelessWidget {
  const NoMoneyAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Sorry',
        style: titleTextStyle,
      ),
      content: const Text("Your don't have enough money on your account.",
          style: bodyTextStyle),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
