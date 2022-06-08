import 'package:ev_chargers/style.dart';
import 'package:flutter/material.dart';
import 'package:ev_chargers/screens/change_password_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> settingTitles = ["Profile settings", "App settings", "Privacy policy", "Notification", "Logout"];
  List<Icon> settingsIcons = [const Icon(Icons.person), Icon(Icons.app_settings_alt) ,Icon(Icons.privacy_tip), Icon(Icons.notifications), Icon(Icons.logout)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
            const SizedBox(height: 10,),
            Card(
              elevation: 8,
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
              margin:const EdgeInsets.fromLTRB(16,8,16,8),
              child: Column(
                children:  [const ListTile(
                title: Text("Personal",
                style: bodyTextStyle,),
              ),
              ListTile(
                leading:const Icon(Icons.person_outline_outlined,
                                color: Colors.black,),
                title: const Text("Personal",
                style: buttonTextStyle,),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.black,), 
                      onPressed: () {
                   Navigator.push(context,MaterialPageRoute(builder: (context) => ChangePasswordScreen())); },
              )),
              const ListTile(
                leading: Icon(Icons.edit_outlined,
                color: Colors.black,),
                title: Text("Survays",
                style: buttonTextStyle,),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                        color: Colors.black,), 
                      onPressed:null,
              )),
              const ListTile(
                leading: Icon(Icons.place_outlined,
                    color:Colors.black),
                title: Text("Suggest a Charger",
                style: buttonTextStyle,),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                        color: Colors.black,), 
                      onPressed:null,
              )
              ),],
              ),
            ),


            const SizedBox(height: 10,),
            Card(
              elevation: 8,
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
              margin:const EdgeInsets.fromLTRB(16,8,16,8),
              child: Column(
                children:const [ListTile(
                title: Text("Payments",
                style: bodyTextStyle,),
              ),
              ListTile(
                leading: Icon(Icons.payment_outlined,
                                color: Colors.black,),
                title: Text("Payment Method",
                style: buttonTextStyle,),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                        color: Colors.black,), 
                      onPressed:null,
              )
              ),
              ListTile(
                leading: Icon(Icons.bolt_outlined,
                color: Colors.black,),
                title: Text("My Pricing",
                style: buttonTextStyle,),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                        color: Colors.black,), 
                      onPressed:null,
              )
              ),
              ListTile(
                leading: Icon(Icons.ev_station_outlined,
                    color:Colors.black),
                title: Text("My Charging",
                style: buttonTextStyle,),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                        color: Colors.black,), 
                      onPressed:null,
              )
              ),
              ListTile(
                leading: Icon(Icons.confirmation_num_outlined,
                    color:Colors.black),
                title: Text("Promotions",
                style: buttonTextStyle,),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                        color: Colors.black,), 
                      onPressed:null,
              )
              ),],
              ),
            ),

            const SizedBox(height: 10,),
            Card(
              elevation: 8,
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
              margin:const EdgeInsets.fromLTRB(16,8,16,8),
              child: Column(
                children:const [ListTile(
                title: Text("Information",
                style: bodyTextStyle,),
              ),
              ListTile(
                leading: Icon(Icons.call_outlined,
                                color: Colors.black,),
                title: Text("Live Support",
                style: buttonTextStyle,),
                trailing: Icon(Icons.arrow_forward_ios,
                color: Colors.black,),
              ),
              ListTile(
                leading: Icon(Icons.alternate_email,
                color: Colors.black,),
                title: Text("Contact",
                style: buttonTextStyle,),
                trailing: Icon(Icons.arrow_forward_ios,
                color: Colors.black,),
              ),
              ListTile(
                leading: Icon(Icons.question_answer_outlined,
                    color:Colors.black),
                title: Text("FAQ",
                style: buttonTextStyle,),
                trailing: Icon(Icons.arrow_forward_ios,
                    color:Colors.black),
              ),
              ListTile(
                leading: Icon(Icons.key_outlined,
                    color:Colors.black),
                title: Text("App Premission",
                style: buttonTextStyle,),
                trailing: Icon(Icons.arrow_forward_ios,
                    color:Colors.black),
              ),
              ListTile(
                leading: Icon(Icons.help_outline,
                    color:Colors.black),
                title: Text("App information",
                style: buttonTextStyle,),
                trailing: Icon(Icons.arrow_forward_ios,
                    color:Colors.black),
              ),],
              ),
            ),
            const SizedBox(height: 10,),
            Card(
              elevation: 8,
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
              margin:const EdgeInsets.fromLTRB(16,8,16,8),
              child: ElevatedButton(
              style:myElevatedButtonStyle,
              onPressed: (() => {}),
              child: const Text("Log out")),
            )  
          ],
        ),
      )
    ;}
}
