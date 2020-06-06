import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//color pallet
final Color primaryColor = Color(0xFF1A237E);
final Color primaryVariant = Color(0xFF171E6B);
final Color secondaryColor = Color(0xFFC2185B);
final Color secondaryVariant = Color(0xFFAF1753);
final Color backgroundColor = Color(0xFFeeeeee);
final Color cardBackgroundColor = Colors.white;
final Color button1Color = Color(0xFF3A9BBF);
final Color errorColor = Color(0xFFCD1C1C);
final Color green1Color = Color(0xFF05A719);
final Color green2Color = Color(0xFFCFF82A);

//themes light
final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  accentColor: secondaryColor,
  canvasColor: backgroundColor,
  primaryColorDark: Colors.grey[300],
  scaffoldBackgroundColor: backgroundColor,
  colorScheme: ColorScheme(
    primary: primaryColor,
    primaryVariant: primaryVariant,
    secondary: secondaryColor,
    secondaryVariant: secondaryVariant,
    surface: cardBackgroundColor,
    background: backgroundColor,
    error: errorColor,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    // todo : check brightness later
    brightness: Brightness.light,
  ),

  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    elevation: 3,
    textTheme: TextTheme(
      title: TextStyle(
        fontFamily: 'yekan',
        fontSize: 25,
      ),
      subtitle: TextStyle(
        fontFamily: 'yekan',
        fontSize: 16,
      ),
    ),
  ),
  primaryTextTheme: TextTheme(

  ),
  textTheme: TextTheme(

    //textfield style
    display1: TextStyle(
      fontFamily: 'yekan',
      fontSize: 16,
      color: Colors.black87
    ),

    //textfield editable text style
    display2: TextStyle(
//        fontFamily: 'yekan',
        fontSize: 16,
        color: Colors.black87
    ),

    title: TextStyle(
      fontFamily: 'yekan',
      fontSize: 22,
      color: Colors.black87,
    ),
    subtitle: TextStyle(
      fontFamily: 'yekan',
      fontSize: 18,
      color: Colors.black54,
    ),
    caption: TextStyle(
      fontFamily: 'yekan',
      fontSize: 13,
      color: Colors.black,
    ),
    overline: TextStyle(
      fontFamily: 'yekan',
      fontSize: 10,
      color: Colors.black,
    ),
  ),
);

//final ThemeData lightTheme = ThemeData.light().copyWith(
//  primaryColor: primaryColor,
//  buttonColor: secondaryColor,
//  buttonTheme: ButtonThemeData(
//    height: 40,
//    buttonColor: secondaryColor,
//    shape: RoundedRectangleBorder(
//      borderRadius: BorderRadius.circular(20.0),
//    ),
//  ),
//
//
//  textTheme: TextTheme(
//
//    // simple text style
//    display1: TextStyle(
//      color: Colors.black,
//      fontFamily: 'yekan',
//      fontSize: 18,
//    ),
//
//    // autoComplete TextField style
//    display3: TextStyle(
//      color: Colors.black,
//      fontSize: 18
//    ),
//
//    // dropdown list text style
//    display2: TextStyle(
//      color: Colors.black54,
//      fontFamily: 'yekan',
//      fontSize: 14,
//    ),
//
//    // english list item style
//    display4: TextStyle(
//      color: Colors.black,
//      fontSize: 25
//    ),
//
//    // appbar title style
//    title: TextStyle(
//      color: Colors.white,
//      fontFamily: 'yekan',
//      fontSize: 24,
//    ),
//
//    // subtitle style
//    subtitle: TextStyle(
//      color: Colors.black,
//      fontFamily: 'yekan',
//      fontSize: 23,
//    ),
//
//    // button style
//    button: TextStyle(
//      color: Colors.white,
//      fontFamily: 'yekan',
//      fontSize: 20,
//    ),
//
//    // caption style
//    caption: TextStyle(
//      color: Colors.black,
//      fontFamily: 'yekan',
//      fontSize: 15,
//    ),
//
//  ),
//);
