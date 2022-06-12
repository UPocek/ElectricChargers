import 'package:ev_chargers/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'style.dart';
import 'helper.dart';
import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkIfUserIsLoggedIn();
  }

  checkIfUserIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedIn = prefs.getBool('loggedIn');
      User.getData(prefs.getString('userId'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: myIconTheme,
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
        tabBarTheme: myTabBarTheme,
      ),
      home: loggedIn == true ? const HomeScreen() : const WelcomeScreen(0),
    );
  }
}
