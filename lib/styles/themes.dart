import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var defaultColor = Colors.black;
var defaultDarkColor = Colors.white;
var defaultBlueColor = Colors.blue;

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultBlueColor,
  scaffoldBackgroundColor: Colors.black,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: defaultDarkColor,
      backgroundColor: Colors.black,
      elevation: 20.0,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey),
  appBarTheme: AppBarTheme(
      elevation: 0.0,
      titleSpacing: 20.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light),
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
          color: defaultDarkColor,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          fontFamily: "Jannah"),
      actionsIconTheme: IconThemeData(color: defaultDarkColor)),
  textTheme: const TextTheme(
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.3
      ),
      bodyText1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white)),
  fontFamily: 'Jannah',
);

ThemeData lightTheme = ThemeData(
    textTheme: const TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        subtitle1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            height: 1.3
        ),
        bodyText2: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black)),
    primarySwatch: defaultBlueColor,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: defaultColor),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: defaultColor),
      titleSpacing: 20.0,
      titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: "Jannah"),
      elevation: 0.0,
      backgroundColor: Colors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: defaultColor,
        elevation: 20.0),
    fontFamily: 'Jannah');
