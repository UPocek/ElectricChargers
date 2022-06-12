import 'package:ev_chargers/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome_screen.dart';
import 'screens/homepage.dart';
import 'style.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? logedIn;

  @override
  void initState() {
    super.initState();
    checkIfUserLogedIn();
  }

  checkIfUserLogedIn() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      logedIn = prefs.getBool("logedIn");
    });
  }


  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.selected,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return Colors.black;
    }

  return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevatedButtonTheme:
              ElevatedButtonThemeData(style: myElevatedButtonStyle),
          colorScheme: mainColorScheme,
          appBarTheme: const AppBarTheme(
            titleTextStyle: appBarTextStyle,
          ),
          textTheme: const TextTheme(
            subtitle1: titleTextStyle,
            bodyText1: bodyTextStyle,
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.white,
            labelStyle: navBarTextStyle,
            unselectedLabelColor: navBarTextStyle.color,
            overlayColor: MaterialStateProperty.resolveWith(getColor),
            indicator:  BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.pink.shade300,
            )
        )),
        home: logedIn == true ? const MyHome() : const WelcomeScreen(0),
      );
    }
}
