import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/splashScreen.jpg'),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 140,
                    child: Text(
                      'PlanB',
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontSize: 55,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(blurRadius: 10, color: Colors.black54)
                        ],
                      ),
                    ),
                  ),
                  SpinKitThreeBounce(
                    color: Colors.white,
                    size: 35,
                  ),
                  Positioned(
                    bottom: 5,
                    child: Text(
                      'Tetha',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(blurRadius: 10, color: Colors.black54)
                        ],
                        height: 2.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
