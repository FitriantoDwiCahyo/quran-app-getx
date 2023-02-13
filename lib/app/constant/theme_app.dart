import 'package:flutter/material.dart';

const purple = Color(0xFF672CBC);
const purpleDark = Color(0xFF240F4F);
const grey = Color(0xFF8789A3);
const white = Color(0xFFFFFFFF);
const purpleLight = Color(0xFFA44AFF);

const purple1 = Color(0xFFDF98FA);
const purple2 = Color(0xFF9055FF);

const iconColor = Color(0xFF863ED5);
const btnColor = Color(0xFFF9B091);

const bgLight = Color(0xFFFFFFFF);
const bgDark = Color(0xFF282A3A);

var cardDark = grey.withOpacity(1.0);
var cardLight = Color(0xFF121931).withOpacity(1.0);

ThemeData lightMode = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: bgLight,
    iconTheme: IconThemeData(color: grey),
    // shadowColor: Colors.transparent,
    elevation: 0,
  ),
  scaffoldBackgroundColor: bgLight,
  textTheme: const TextTheme(
    //text color purple
    headline1: TextStyle(
      color: purple,
      fontSize: 26,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: purple,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontSize: 16,
      color: purpleDark,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      color: purpleDark,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),

    //text color grey
    headline5: TextStyle(
      color: grey,
      fontSize: 18,
    ),
    headline6: TextStyle(
      color: grey,
      fontSize: 16,
    ),
    subtitle1: TextStyle(
      color: grey,
      fontSize: 12,
    ),
    caption: TextStyle(
      color: grey,
      fontSize: 12,
    ),

    //text color white
    bodyText1: TextStyle(
      fontSize: 14,
      color: white,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      fontSize: 18,
      color: white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: btnColor,
      textStyle: const TextStyle(
        color: white,
        fontSize: 19,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      fixedSize: Size(185, 60),
    ),
  ),
);
ThemeData darkMode = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: bgDark,
    elevation: 0,
  ),
  scaffoldBackgroundColor: bgDark,
  textTheme: const TextTheme(
    headline1: TextStyle(
      color: white,
      fontSize: 26,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      color: white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),

    //text color grey
    headline5: TextStyle(
      color: grey,
    ),
    headline6: TextStyle(
      color: grey,
      fontSize: 16,
    ),
    subtitle1: TextStyle(
      color: grey,
      fontSize: 12,
    ),
    caption: TextStyle(
      color: grey,
      fontSize: 12,
    ),

    //text color white
    bodyText1:
        TextStyle(fontSize: 14, color: white, fontWeight: FontWeight.bold),
    bodyText2: TextStyle(
      fontSize: 18,
      color: white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: btnColor,
      textStyle: const TextStyle(
        color: purple,
        fontSize: 19,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      fixedSize: Size(185, 60),
    ),
  ),
);
