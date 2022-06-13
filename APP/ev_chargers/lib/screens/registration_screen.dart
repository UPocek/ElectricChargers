import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../widgets/big_text_field.dart';
import 'credit_card_screen.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController =
      TextEditingController();

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
                "Tell us how you are ⚡️",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: Column(
                  children: [
                    BigTextField(firstNameController, TextInputType.name,
                        "First name*", false),
                    BigTextField(lastNameController, TextInputType.text,
                        "Last name*", false),
                    BigTextField(emailController, TextInputType.emailAddress,
                        "Email*", false),
                    BigTextField(passwordController,
                        TextInputType.visiblePassword, "Password*", true),
                    BigTextField(
                        passwordRepeatController,
                        TextInputType.visiblePassword,
                        "Repeat password*",
                        true),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: (() => createAccount(context)),
                      child: const Text("Submit"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  createAccount(BuildContext context) async {
    if (!areInputsValid(context)) return;
    String id = await User.register(firstNameController.text,
        lastNameController.text, emailController.text, passwordController.text);
    if (id != "") {
      await remeberThatUserLogedIn(id);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CreditCardScreen()));
    } else {
      showError(context, "Username already taken. Try a new one.");
    }
  }

  remeberThatUserLogedIn(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("loggedIn", true);
    await prefs.setString("userId", id);
  }

  bool areInputsValid(BuildContext context) {
    if (firstNameController.text == "" ||
        lastNameController.text == "" ||
        emailController.text == "" ||
        passwordController.text == "" ||
        passwordController.text == "") {
      showError(context, "Invalide input values");
      return false;
    }
    if (passwordController.text != passwordRepeatController.text) {
      showError(context, "Entered passwords don't match");
      return false;
    }
    return true;
  }

  showError(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Error"),
          content: Text(message),
        );
      },
      barrierDismissible: true,
    );
  }
}
