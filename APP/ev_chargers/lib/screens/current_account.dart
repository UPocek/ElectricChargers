import 'package:ev_chargers/screens/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:ev_chargers/style.dart';

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
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2)),
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  children: const [
                    ListTile(
                      title: Text(
                        "First name:",
                        style: bodyTextStyle,
                      ),
                      subtitle: Text("Marko"),
                    ),
                    ListTile(
                      title: Text(
                        "Last name:",
                        style: bodyTextStyle,
                      ),
                      subtitle: Text("Markovic"),
                    ),
                    ListTile(
                      title: Text(
                        "email:",
                        style: bodyTextStyle,
                      ),
                      subtitle: Text("markomarkovic@gmail.com"),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)),
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: ElevatedButton(
                      style: myElevatedButtonStyle,
                      onPressed: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(),
                          ),
                        );
                      }),
                      child: const Text("Update password")),
                ))
          ],
        ));
  }
}
