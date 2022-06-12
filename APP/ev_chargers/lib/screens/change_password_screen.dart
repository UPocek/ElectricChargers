import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/big_text_field.dart';
import '../style.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        toolbarHeight: 80,
        title: const Text("Update"),
        titleTextStyle: titleTextStyle,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Change your password",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: Column(
                  children: [
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
                        onPressed: (() => {
                              if (passwordController.text == "" ||
                                  passwordRepeatController.text == "")
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Invalide input values"),
                                    ),
                                  ),
                                }
                              else if (passwordController.text !=
                                  passwordRepeatController.text)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Passwords don't match"),
                                    ),
                                  ),
                                }
                              else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Successfuly changed password"),
                                    ),
                                  ),
                                },
                              Navigator.of(context).pop(context)
                            }),
                        child: const Text("Change"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool areInputsValid(BuildContext context) {
    if (passwordController.text == "" || passwordController.text == "") {
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

  showSuccess(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return const CupertinoAlertDialog(
          title: Text("Success"),
          content: Text("Successfuly changed password"),
        );
      },
      barrierDismissible: true,
    );
  }
}
