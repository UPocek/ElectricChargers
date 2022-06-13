import 'package:ev_chargers/helper.dart';
import 'package:ev_chargers/models/reservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../style.dart';

class MakeReservationScreen extends StatelessWidget {
  final String stationId;
  final String stationName;
  final String stationAddress;

  MakeReservationScreen(this.stationId, this.stationName, this.stationAddress,
      {Key? key})
      : super(key: key);

  final TextEditingController dateController = TextEditingController();
  Color? backgroundColor;
  String selectedDate = '';

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        toolbarHeight: 80,
        title: const Text("Reserve your spot"),
        titleTextStyle: titleTextStyle,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CentralEmoji('⏰'),
            Text(
              'Make reservation for your EV at $stationName',
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
              child: TextField(
                onTap: () {
                  DatePicker.showDateTimePicker(context,
                      theme:
                          const DatePickerTheme(backgroundColor: Colors.white),
                      showTitleActions: true,
                      minTime: DateTime(
                          now.year, now.month, now.day, now.hour, now.minute),
                      maxTime:
                          DateTime(now.year, now.month + 1, now.day, 23, 59),
                      onChanged: (date) {
                    dateController.text =
                        '${date.year}-${date.month >= 10 ? date.month : date.month.toString().padLeft(2, '0')}-${date.day >= 10 ? date.day : date.day.toString().padLeft(2, '0')} at ${date.hour >= 10 ? date.hour : date.hour.toString().padLeft(2, '0')}:${date.minute >= 10 ? date.minute : date.minute.toString().padLeft(2, '0')}';
                    selectedDate =
                        '${date.year}-${date.month >= 10 ? date.month : date.month.toString().padLeft(2, '0')}-${date.day >= 10 ? date.day : date.day.toString().padLeft(2, '0')}T${date.hour >= 10 ? date.hour : date.hour.toString().padLeft(2, '0')}:${date.minute >= 10 ? date.minute : date.minute.toString().padLeft(2, '0')}';
                  }, onConfirm: (date) {
                    dateController.text =
                        '${date.year}-${date.month >= 10 ? date.month : date.month.toString().padLeft(2, '0')}-${date.day >= 10 ? date.day : date.day.toString().padLeft(2, '0')} at ${date.hour >= 10 ? date.hour : date.hour.toString().padLeft(2, '0')}:${date.minute >= 10 ? date.minute : date.minute.toString().padLeft(2, '0')}';
                    selectedDate =
                        '${date.year}-${date.month >= 10 ? date.month : date.month.toString().padLeft(2, '0')}-${date.day >= 10 ? date.day : date.day.toString().padLeft(2, '0')}T${date.hour >= 10 ? date.hour : date.hour.toString().padLeft(2, '0')}:${date.minute >= 10 ? date.minute : date.minute.toString().padLeft(2, '0')}';
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                controller: dateController,
                keyboardType: TextInputType.none,
                obscureText: false,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: const InputDecoration(
                  labelText: "Choose date and time",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (() => makeReservation(context)),
              child: const Text("Make reservation"),
            )
          ],
        ),
      ),
    );
  }

  makeReservation(BuildContext context) async {
    if (dateController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Yot must enter desired time"),
        ),
      );
      return;
    }

    if (await Reservation.createReservation(Reservation(
        user?.id, stationId, '$selectedDate:00.000Z', stationName))) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All chargers are busy. Try some other time."),
        ),
      );
    }
  }
}

class CentralEmoji extends StatelessWidget {
  final String emoji;

  const CentralEmoji(this.emoji, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0, bottom: 100.0),
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 80.0),
        ),
      ),
    );
  }
}
