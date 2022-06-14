import 'dart:async';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../style.dart';

class ChargingScreen extends StatefulWidget {
  final String chargerId;
  const ChargingScreen(this.chargerId, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChargingScreenState();
  }
}

class ChargingScreenState extends State<ChargingScreen> {
  double numberOfMinutesCharged = 0;
  bool _stop = false;
  double chargingUpperLimit = 180;
  double kwhPerMinute = 2.5;

  @override
  void initState() {
    super.initState();
    startCharging();
  }

  startCharging() async {
    if (await User.startCharging(widget.chargerId)) {
      startTimer();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error : Charger is already reserved. Try another one"),
        ),
      );
    }
  }

  startTimer() {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (numberOfMinutesCharged == chargingUpperLimit || _stop) {
            payBill();
            timer.cancel();
          } else {
            numberOfMinutesCharged += 1;
          }
        },
      ),
    );
  }

  Future payBill() async {
    double price = await User.payForCharging(
        numberOfMinutesCharged * kwhPerMinute, widget.chargerId);
    return showDialog(
        context: context, builder: (BuildContext context) => BillAlert(price));
  }

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 5,
        toolbarHeight: 80,
        title: const Text("Charging 🔋"),
        titleTextStyle: titleTextStyle,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Quick as Lightning!", style: titleTextStyle),
              SizedBox(
                  height: 400,
                  width: 400,
                  child: Stack(alignment: Alignment.center, children: [
                    const Text(
                      "⚡️",
                      style: TextStyle(fontSize: 100),
                    ),
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: CircularProgressIndicator(
                          semanticsValue: numberOfMinutesCharged.toString(),
                          strokeWidth: 10,
                          backgroundColor: Colors.amber,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.black),
                          value: numberOfMinutesCharged / chargingUpperLimit,
                        )),
                  ])),
              const SizedBox(
                height: 40.0,
              ),
              ElevatedButton(
                child: const Text('Stop charging'),
                onPressed: () {
                  setState(() {
                    _stop = true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BillAlert extends StatelessWidget {
  final double bill;
  const BillAlert(this.bill, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Bill',
        style: titleTextStyle,
      ),
      content: Text('Your bill is $bill \$', style: bodyTextStyle),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context)
            ..pop()
            ..pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
