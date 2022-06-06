import 'package:flutter/material.dart';

const largeTextSize = 28.0;
const mediumTextSize = 20.0;
const bodyTextSize = 18.0;
const miniTextSize = 16.0;

const String fontName = 'Montserrat';

const AppBarTextStyle = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.w600,
  fontSize: mediumTextSize,
  color: Colors.white,
);

const TitleTextStyle = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.w600,
  fontSize: largeTextSize,
  color: Colors.black,
);

const BodyTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w300,
    fontSize: bodyTextSize,
    color: Colors.black,
    height: 1.6);

const ButtonTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w300,
    fontSize: miniTextSize,
    color: Colors.black,
    height: 1.6);

var MainColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.amber);

var MyElevatedButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(
    const EdgeInsets.fromLTRB(28.0, 15.0, 28.0, 15.0),
  ),
  textStyle: MaterialStateProperty.all(ButtonTextStyle),
);
