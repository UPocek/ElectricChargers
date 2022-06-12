import 'package:ev_chargers/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'registration_screen.dart';
import '../models/welcome_entry.dart';

class WelcomeScreen extends StatelessWidget {
  final int index;

  const WelcomeScreen(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = WelcomeEntry.getWelcomeData(index);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() => loadNextScreen(context)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: const Icon(Icons.keyboard_arrow_right),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CentralEmoji(data.emoji),
          WelcomeCard(data.title, data.body),
        ],
      ),
    );
  }

  loadNextScreen(BuildContext context) {
    if (index <= 1) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => WelcomeScreen(index + 1)),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => LogInScreen()),
      ));
    }
  }
}

class CentralEmoji extends StatelessWidget {
  final String emoji;

  const CentralEmoji(this.emoji, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 80.0),
        ),
      ),
    );
  }
}

class WelcomeCard extends StatelessWidget {
  final String title;
  final List<String> body;

  const WelcomeCard(this.title, this.body, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      child: Card(
        margin: const EdgeInsets.only(bottom: 85.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 20.0,
              ),
              RichText(
                text: TextSpan(
                  text: body[0],
                  style: Theme.of(context).textTheme.bodyText1,
                  children: [
                    TextSpan(
                      text: body[1],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
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
