import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//no scrollGlow for scrollable widgets
class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

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
        fontSize: 24,
      ),
      subtitle: TextStyle(
        fontFamily: 'yekan',
        fontSize: 16,
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: secondaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  textTheme: TextTheme(
    //fixme : fix deprecated parts

    //english and persian font
    headline1: TextStyle(
      fontFamily: 'vazir',
      fontSize: 16,
      fontWeight: FontWeight.w100,
      color: Colors.black87,
    ),

    //autocompleteTextfield list item style
    headline2: TextStyle(
      fontFamily: 'vazir',
      fontWeight: FontWeight.w100,
      fontSize: 18,
      color: Colors.black87,
    ),

    //in Screen titles
    headline3: TextStyle(
      fontFamily: 'vazir',
      fontWeight: FontWeight.w500,
      fontSize: 22,
      color: Colors.black87,
    ),

    //home Card title Style
    headline4: TextStyle(
      fontFamily: 'vazir',
      fontSize: 16,
      color: Colors.grey[800],
      fontWeight: FontWeight.w500,
    ),

    //snackbar text style
    headline5: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'vazir',
      fontWeight: FontWeight.w500,
    ),,

    caption: TextStyle(
      fontFamily: 'vazir',
      fontSize: 14,
      color: Colors.black,
    ),

    overline: TextStyle(
      fontFamily: 'yekan',
      fontSize: 10,
      color: Colors.black,
    ),

    button: TextStyle(
      fontFamily: 'yekan',
      fontSize: 17,
      color: Colors.white,
    ),
  ),
);
