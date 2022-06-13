import 'dart:async';

import 'package:flutter/material.dart';

import '../models/user.dart';
import '../style.dart';

class ChargingScreen extends StatefulWidget {
  const ChargingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChargingScreenState();
  }
}

class ChargingScreenState extends State<ChargingScreen> {
  double _progress = 0;
  late bool _stop = false;

  @override
  void initState() {
    super.initState();
    _progress = 0;
    startTimer();
  }

  void startTimer() {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_progress == 1 || _stop) {
            timer.cancel();
          } else {
            _progress += 0.01;
          }
        },
      ),
    );
  }

  Future<String?> payBill() {
    User.payForCharging(_progress);
    return showDialog<String>(
        context: context, builder: (Widget) => BillAlert(_progress));
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
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Quick as Lightning!", style: titleTextStyle),
                SizedBox(
                    height: 400,
                    width: 400,
                    child: Stack(alignment: Alignment.center, children: [
                      Text(
                        "⚡️",
                        style: TextStyle(fontSize: 100),
                      ),
                      SizedBox(
                          height: 200,
                          width: 200,
                          child: CircularProgressIndicator(
                            semanticsValue: _progress.toString(),
                            strokeWidth: 10,
                            backgroundColor: Colors.amber,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.black),
                            value: _progress,
                          )),
                    ])),
                const SizedBox(
                  height: 40.0,
                ),
                ElevatedButton(
                  child: Text('Stop charging'),
                  onPressed: () {
                    setState(() {
                      _stop = true;
                    });
                    payBill();
                  },
                ),
              ],
            ),
          ),
        ));
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
      content: Text('Your bill is ' + (bill * 1000000).toString() + ' dollars.',
          style: bodyTextStyle),
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
