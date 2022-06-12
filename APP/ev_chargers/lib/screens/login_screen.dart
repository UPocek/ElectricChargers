import 'package:ev_chargers/screens/home_screen.dart';
import 'package:ev_chargers/screens/registration_screen.dart';
import 'package:ev_chargers/widgets/padding_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../helper.dart';
import '../widgets/big_text_field.dart';
import 'credit_card_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Log in ⚡️",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: Column(
                  children: [
                    BigTextField(emailController, TextInputType.emailAddress,
                        "Email*", false),
                    BigTextField(passwordController,
                        TextInputType.visiblePassword, "Password*", true),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: (() => {signInAccount(context)}),
                      child: const Text("Sign in"),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: InkWell(
                            child: const Text("Don't have an account yet?"),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) =>
                                      RegistrationScreen())));
                            }))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signInAccount(BuildContext context) async {
    if (!areInputsValid(context)) return;
    String id = await User.logIn(emailController.text, passwordController.text);
    if (id != "") {
      await remeberThatUserLogedIn(id);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {}
  }

  remeberThatUserLogedIn(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("loggedIn", true);
    await prefs.setString("userId", id);
  }

  bool areInputsValid(BuildContext context) {
    if (emailController.text == "" || passwordController.text == "") {
      return false;
    }
    return true;
  }
}
