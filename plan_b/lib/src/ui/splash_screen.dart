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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text("sign up"),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => SignUpScreen()
                    ));
              },
            ),
            FlatButton(
              child: Text("complete"),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => CompleteProfileScreen()
                    ));
              },
            ),
            FlatButton(
              child: Text("Home"),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen()
                    ));
              },
            ),
            FlatButton(
              child: Text("Login"),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen()
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
