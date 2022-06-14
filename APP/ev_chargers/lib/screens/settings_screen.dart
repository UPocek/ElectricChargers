import 'package:ev_chargers/screens/current_account.dart';
import 'package:ev_chargers/screens/login_screen.dart';
import 'package:ev_chargers/screens/prepaid_screen.dart';
import 'package:ev_chargers/style.dart';
import 'package:ev_chargers/widgets/action_button.dart';
import 'package:ev_chargers/widgets/padding_card.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'create_reservation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        PaddingCard(SettingsCard("Personal", [
          CardItem(Icons.person_outline_outlined, "Current Account",
              function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CurrentAccount(),
              ),
            );
          }),
          const CardItem(Icons.edit_outlined, "Survays"),
          CardItem(
            Icons.place_outlined,
            "Suggest a Charger",
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateReservationScreen(
                      '961256b6-e1a8-4e87-aa47-5b38cb25820b',
                      'Galerija',
                      'Bulevar Vudroa Vilsona 12'),
                ),
              );
            },
          ),
        ])),
        PaddingCard(SettingsCard("Payments", [
          CardItem(Icons.payment_outlined, "Prepaid", function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrepaidScreen(),
                ));
          }),
          const CardItem(Icons.bolt_outlined, "My Pricing"),
          const CardItem(Icons.ev_station_outlined, "My Charging"),
          const CardItem(Icons.confirmation_num_outlined, "Promotions"),
        ])),
        const PaddingCard(SettingsCard("Information", [
          CardItem(Icons.call_outlined, "Live Support"),
          CardItem(Icons.alternate_email, "Contact"),
          CardItem(Icons.question_answer_outlined, "FAQ"),
          CardItem(Icons.key_outlined, "App Premission"),
          CardItem(Icons.help_outline, "App information"),
        ])),
        ActionButton(
            "Log out",
            (() => {
                  User.logOut(),
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => LogInScreen())))
                })),
      ]),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final String title;
  final List<CardItem> items;

  const SettingsCard(this.title, this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: bodyTextStyle,
          ),
        ),
        ...items
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? function;

  const CardItem(this.icon, this.title, {Key? key, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
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
