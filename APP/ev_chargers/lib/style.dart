import 'package:flutter/material.dart';

const largeTextSize = 28.0;
const mediumTextSize = 20.0;
const bodyTextSize = 18.0;
const miniTextSize = 16.0;

const minimumTextSize = 12.0;

const String fontName = 'Montserrat';

const appBarTextStyle = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.w600,
  fontSize: mediumTextSize,
  color: Colors.white,
);

const navBarTextStyle = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.w600,
  fontSize: minimumTextSize,
  color: Colors.black,
);

const titleTextStyle = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.w600,
  fontSize: largeTextSize,
  color: Colors.black,
);

const bodyTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: bodyTextSize,
    color: Colors.black,
    height: 1.6);

const buttonTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: miniTextSize,
    color: Colors.black,
    height: 1.6);

var mainColorScheme = ColorScheme.fromSwatch(
  primarySwatch: Colors.amber,
  accentColor: Colors.amber,
);

var myElevatedButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(
    const EdgeInsets.fromLTRB(28.0, 15.0, 28.0, 15.0),
  ),
  textStyle: MaterialStateProperty.all(buttonTextStyle),
);

var myIconTheme = const IconThemeData(
  color: Colors.black,
);

var myTabBarTheme = TabBarTheme(
  labelColor: Colors.white,
  labelStyle: navBarTextStyle,
  unselectedLabelColor: navBarTextStyle.color,
  indicator: BoxDecoration(
    borderRadius: BorderRadius.circular(6),
    color: Colors.amber,
  ),
);

var iconTheme = const IconThemeData(
  color: Colors.black,
);
