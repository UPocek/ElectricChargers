import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../style.dart';

class PrepaidScreen extends StatelessWidget {
  final TextEditingController _moneyController = TextEditingController();
  PrepaidScreen({Key? key}) : super(key: key);

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
        title: const Text("Prepaid"),
        titleTextStyle: titleTextStyle,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 40.0),
            child: Text(
              textAlign: TextAlign.center,
              "Pay in advance and get great discounts 💸",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Card(
              elevation: 12,
              color: Colors.amber,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    "Enter the amount:",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: fontName,
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _moneyController,
                          style: prepaidTextStyle,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 5.0,
                                )),
                            suffixIcon: const Icon(
                              Icons.attach_money_outlined,
                              color: Colors.white,
                            ),
                            focusColor: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          style: formButton,
                          onPressed: (() => {
                                // User.addCash(user?.id,
                                //     int.parse(_moneyController.text)),
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Successfuly added money to your account"),
                                  ),
                                ),
                                Navigator.of(context).pop(context)
                              }),
                          child: const Text(
                            "Pay",
                            style: formButtonTextStyle,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
