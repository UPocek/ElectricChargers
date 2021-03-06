import 'package:ev_chargers/widgets/action_button.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
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
    bool ok;
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
                    ActionButton(
                      "Change",
                      () async => {
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
                            ok = await User.updatePassword(
                                passwordController.text),
                            if (ok)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Successfuly changed password"),
                                  ),
                                ),
                              }
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Password change failed"),
                                  ),
                                ),
                              }
                          },
                        Navigator.of(context).pop(context)
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
