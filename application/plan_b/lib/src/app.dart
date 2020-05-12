import 'package:flutter/material.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/home_screen.dart';
import 'package:planb/src/ui/splash_screen.dart';

class PlanBApp extends StatefulWidget {
  @override
  _PlanBAppState createState() => _PlanBAppState();
}

class _PlanBAppState extends State<PlanBApp> {

  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode? ThemeData.dark() : lightTheme,
      home: SplashScreen()
    );
  }
}
