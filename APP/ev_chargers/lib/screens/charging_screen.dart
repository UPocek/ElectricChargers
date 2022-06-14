import 'dart:async';
import 'package:flutter/material.dart';
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
  double _price = 0;

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
          if (_progress == 180 || _stop) {
            payBill();
            timer.cancel();
          } else {
            _progress += 10;
          }
        },
      ),
    );
  }

  Future payBill() {
    // double price = User.payForCharging(_progress);
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => BillAlert(_progress));
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
                            semanticsValue: _progress.toString(),
                            strokeWidth: 10,
                            backgroundColor: Colors.amber,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.black),
                            value: _progress / 180,
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
