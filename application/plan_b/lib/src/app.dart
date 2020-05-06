import 'package:flutter/material.dart';
import 'package:planb/src/ui/signup_screen.dart';
import 'ui/splash_screen.dart';

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
      theme: isDarkMode? ThemeData.dark() : ThemeData.light(),
      color: Colors.indigo,
      home: SignupScreen()
    );
  }
}
