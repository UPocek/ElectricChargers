import 'package:ev_chargers/screens/current_account.dart';
import 'package:ev_chargers/style.dart';
import 'package:flutter/material.dart';
import 'package:ev_chargers/screens/change_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          SettingsCard("Personal", [
            CardItem(Icons.person_outline_outlined, "Personal"),
            CardItem(Icons.edit_outlined, "Survays"),
            CardItem(Icons.place_outlined, "Suggest a Charger"),
          ]),
          SettingsCard("Payments", [
            CardItem(Icons.payment_outlined, "Payment Method"),
            CardItem(Icons.bolt_outlined, "My Pricing"),
            CardItem(Icons.ev_station_outlined, "My Charging"),
            CardItem(Icons.confirmation_num_outlined, "Promotions"),
          ]),
          SettingsCard("Information", [
            CardItem(Icons.call_outlined, "Live Support"),
            CardItem(Icons.alternate_email, "Contact"),
            CardItem(Icons.question_answer_outlined, "FAQ"),
            CardItem(Icons.key_outlined, "App Premission"),
            CardItem(Icons.help_outline, "App information"),
          ]),
          LogOutButton(),
        ],
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final String title;
  final List<CardItem> items;

  const SettingsCard(this.title, this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            ListTile(
              title: Text(
                title,
                style: bodyTextStyle,
              ),
            ),
            ...items
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const CardItem(this.icon, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CurrentAccount(),
          ),
        );
      }),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        title: Text(
          title,
          style: buttonTextStyle,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
        ),
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: ElevatedButton(
            style: myElevatedButtonStyle,
            onPressed: (() => {}),
            child: const Text("Log out")),
      ),
    );
  }
}
