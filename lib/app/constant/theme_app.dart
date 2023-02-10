import 'package:flutter/material.dart';

const txtColorTitle = Color(0xFF672CBC);
const txtColorPrimary = Color(0xFF240F4F);
const txtColorSecondary = Color(0xFF863ED5);
const txtColorLight = Color(0xFF8789A3);
const txtColorWhite = Color(0xFFFFFFFF);

const purpleLight = Color(0xFFA44AFF);
const purple1 = Color(0xFFDF98FA);
const purple2 = Color(0xFF9055FF);

const iconColor = Color(0xFF863ED5);

const btnColor = Color(0xFFF9B091);

const bgLight = Color(0xFFFFFFFF);
const bgDark = Color(0xFF282A3A);

ThemeData lightMode = ThemeData(
  appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
  scaffoldBackgroundColor: bgLight,
  textTheme: const TextTheme(
    headline5: TextStyle(
      color: txtColorTitle,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    ),
    headline6: TextStyle(color: txtColorTitle),
    subtitle1: TextStyle(color: txtColorLight),
    subtitle2: TextStyle(color: txtColorPrimary),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: btnColor,
      textStyle: TextStyle(color: txtColorWhite),
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
    headline5: TextStyle(
      color: txtColorWhite,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    ),
    headline6: TextStyle(color: txtColorWhite),
    subtitle1: TextStyle(color: txtColorWhite),
    subtitle2: TextStyle(color: txtColorLight),
    bodyText1: TextStyle(color: txtColorLight,fontSize: 18),
    bodyText2: TextStyle(color: txtColorWhite),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: btnColor,
      textStyle: TextStyle(color: txtColorPrimary),
    ),
  ),
);
