import 'package:flutter/material.dart';

class BigTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboard;
  final String hintText;
  final bool obscureText;

  const BigTextField(
      this.controller, this.keyboard, this.hintText, this.obscureText,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        obscureText: obscureText,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          labelText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
