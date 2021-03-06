import 'package:ev_chargers/helper.dart';
import 'package:ev_chargers/screens/change_password_screen.dart';
import 'package:ev_chargers/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:ev_chargers/style.dart';
import '../widgets/padding_card.dart';

class CurrentAccount extends StatelessWidget {
  const CurrentAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        toolbarHeight: 80,
        title: const Text("Current Account"),
        titleTextStyle: titleTextStyle,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          PaddingCard(
            Column(
              children: [
                AccountItem("First name", user?.firstName ?? ''),
                AccountItem("Last name", user?.lastName ?? ''),
                AccountItem("Email", user?.email ?? ''),
              ],
            ),
          ),
          ActionButton("Update password", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangePasswordScreen(),
              ),
            );
          })
        ],
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const AccountItem(this.title, this.subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: bodyTextStyle,
      ),
      subtitle: Text(subtitle),
    );
  }
}
