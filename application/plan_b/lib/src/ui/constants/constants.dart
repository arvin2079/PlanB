import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//color pallet
final Color primaryColor = Color(0xFF1A237E);
final Color secondaryColor = Color(0xFFC2185B);
final Color backgroundColor = Color(0xFFeeeeee);
final Color button1Color = Color(0xFF3A9BBF);
final Color dangerColor = Color(0xFFCD1C1C);
final Color green1Color = Color(0xFF05A719);
final Color green2Color = Color(0xFFCFF82A);

//themes light
final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  buttonColor: secondaryColor,
  buttonTheme: ButtonThemeData(
    height: 40,
    buttonColor: secondaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),

  textTheme: TextTheme(

    // simple text style
    display1: TextStyle(
      color: Colors.black,
      fontFamily: 'yekan',
      fontSize: 18,
    ),

    // autoComplete TextField style
    display3: TextStyle(
      color: Colors.black,
      fontSize: 18
    ),

    // dropdown list text style
    display2: TextStyle(
      color: Colors.black54,
      fontFamily: 'yekan',
      fontSize: 14,
    ),

    // english list item style
    display4: TextStyle(
      color: Colors.black,
      fontSize: 25
    ),

    // appbar title style
    title: TextStyle(
      color: Colors.white,
      fontFamily: 'yekan',
      fontSize: 24,
    ),

    // subtitle style
    subtitle: TextStyle(
      color: Colors.black,
      fontFamily: 'yekan',
      fontSize: 23,
    ),

    // button style
    button: TextStyle(
      color: Colors.white,
      fontFamily: 'yekan',
      fontSize: 20,
    ),

    // caption style
    caption: TextStyle(
      color: Colors.black,
      fontFamily: 'yekan',
      fontSize: 15,
    ),

  ),
);
