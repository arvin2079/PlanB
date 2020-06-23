import 'package:flutter/material.dart';
import 'package:planb/src/ui/home_screen.dart';
import 'package:planb/src/ui/login_screen.dart';
import 'package:planb/src/ui/complete_profile_screen.dart';
import 'package:planb/src/ui/signup_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }
}
