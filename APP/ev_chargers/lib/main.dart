import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
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
      // logedIn = prefs.getBool("logedIn");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: MyElevatedButtonStyle),
        colorScheme: MainColorScheme,
        appBarTheme: const AppBarTheme(
          titleTextStyle: AppBarTextStyle,
        ),
        textTheme: const TextTheme(
          subtitle1: TitleTextStyle,
          bodyText1: BodyTextStyle,
        ),
      ),
      home: logedIn == true ? HomeScreen() : WelcomeScreen(0),
    );
  }
}
