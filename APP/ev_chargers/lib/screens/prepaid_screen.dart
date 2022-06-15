import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helper.dart';
import '../models/user.dart';
import '../style.dart';

class PrepaidScreen extends StatelessWidget {
  final TextEditingController _moneyController = TextEditingController();

  final Function updateUserInfo;

  PrepaidScreen(this.updateUserInfo, {Key? key}) : super(key: key);

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
      body: ListView(
        children: [
          const Heading(),
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
                  const Padding(
                    padding: EdgeInsets.only(top: 60.0, bottom: 50.0),
                    child: Text(
                      "Enter the amount:",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: fontName,
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: TextField(
                            textAlign: TextAlign.end,
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
                            cursorColor: Colors.white,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: formButton,
                          onPressed: (() async => {
                                if (double.parse(_moneyController.text) > 0)
                                  {
                                    await User.addCash(user?.id,
                                        double.parse(_moneyController.text)),
                                    updateUserInfo(),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Successfuly added money to your account"),
                                      ),
                                    ),
                                  }
                                else
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "You can't added negative sum of money"),
                                      ),
                                    ),
                                  },
                                Navigator.of(context).pop()
                              }),
                          child: const Text(
                            "Pay",
                            style: formButtonTextStyle,
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
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

class Heading extends StatelessWidget {
  const Heading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 40.0),
      child: Text(
        textAlign: TextAlign.center,
        "Pay in advance and get great discounts 💸",
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
