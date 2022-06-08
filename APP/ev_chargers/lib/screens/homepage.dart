import 'package:ev_chargers/style.dart';
import 'package:flutter/material.dart';
import 'map_page.dart';
import 'reservation_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const List<Tab> navigationTabs = <Tab>[
    Tab(icon: Icon(Icons.person_outline),),
              Tab(icon: Icon(Icons.calendar_today_outlined),),
              Tab(icon: Icon(Icons.map_outlined),),
              Tab( icon: Icon(Icons.settings_outlined),),
  ];
  List<Widget> pages = const [ProfilePage(),ReservationPage(),MapPage(), SettingsPage()]; 

  @override
  void initState(){
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
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.white,
              blurStyle: BlurStyle.inner
            ),
          ],
        ),
        child: TabBar(
            padding: const EdgeInsets.all(10),
            controller: _tabController,
            tabs: navigationTabs,
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                return states.contains(MaterialState.focused) ? null : Colors.transparent;
              },
          )
        )
      ),
      body: TabBarView(
        controller: _tabController,
            children: pages,
      ),
      floatingActionButton:
      FloatingActionButton(
          onPressed: ()=>{},
          backgroundColor: Colors.pink.shade300,
          child: const Icon(Icons.bolt, color: Colors.white,)
          )
          );
  }
}


