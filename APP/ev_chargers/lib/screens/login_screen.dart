import 'package:ev_chargers/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

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
                    MyTextField(firstNameController, TextInputType.name,
                        "First name*", false),
                    MyTextField(lastNameController, TextInputType.text,
                        "Last name*", false),
                    MyTextField(emailController, TextInputType.emailAddress,
                        "Email*", false),
                    MyTextField(passwordController,
                        TextInputType.visiblePassword, "Password*", true),
                    MyTextField(
                        passwordRepeatController,
                        TextInputType.visiblePassword,
                        "Repeat password*",
                        true),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                        onPressed: (() => createAccount(context)),
                        child: const Text("Submit"))
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
    bool successful = await User.register(firstNameController.text,
        lastNameController.text, emailController.text, passwordController.text);
    if (successful) {
      await remeberThatUserLogedIn();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      showError(context, "Username already taken. Try a new one.");
    }
  }

  remeberThatUserLogedIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("logedIn", true);
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
            title: const Text("Error"), content: Text(message));
      },
      barrierDismissible: true,
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboard;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      this.controller, this.keyboard, this.hintText, this.obscureText,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        obscureText: obscureText,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          labelText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}