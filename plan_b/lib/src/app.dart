import 'package:flutter/material.dart';
import 'package:planb/src/ui/complete_profile_screen.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/home_screen.dart';
import 'package:planb/src/ui/login_screen.dart';
import 'package:planb/src/ui/signup_screen.dart';
import 'package:planb/src/ui/splash_screen.dart';

class PlanBApp extends StatefulWidget {
  @override
  _PlanBAppState createState() => _PlanBAppState();
}

class _PlanBAppState extends State<PlanBApp> {

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode? ThemeData.dark() : lightTheme,
      navigatorKey: _navigatorKey,
      routes: {
        '/signup' : (BuildContext context) => SignUpScreen(),
        '/login' : (BuildContext context) => LoginScreen(),
        '/home' : (BuildContext context) => HomeScreen(),
        '/edit_profile' : (BuildContext context) => CompleteProfileScreen(),
      },
      home: SplashScreen()
    );
  }
}
