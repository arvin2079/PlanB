import 'package:flutter/material.dart';
import 'package:planb/src/bloc/authenticatin_bloc.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/ui/about_us_screen.dart';
import 'package:planb/src/ui/complete_profile_screen.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/home_screen.dart';
import 'package:planb/src/ui/login_screen.dart';
import 'package:planb/src/ui/newProject_screen.dart';
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
    authenticationBloc.isUserLoggedIn();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: isDarkMode ? ThemeData.dark() : lightTheme,
        navigatorKey: _navigatorKey,
        routes: {
          '/signup': (BuildContext context) => SignUpScreen(),
          '/login': (BuildContext context) => LoginScreen(),
          '/home': (BuildContext context) => HomeScreen(),
          '/edit_profile': (BuildContext context) => CompleteProfileScreen(),
          '/new_project': (BuildContext context) => NewProjectScreen(),
          '/about_us': (BuildContext context) => AboutUsScreen(),
        },
        home: StreamBuilder<AuthStatus>(
            stream: authenticationBloc.authenticationStatusStream,
            builder: (context, snapshot) {
              Widget result = SplashScreen();

              if (snapshot.hasData) {
                if (snapshot.data == AuthStatus.signedIn) {
                  result = HomeScreen();
                } else if (snapshot.data == AuthStatus.signedOut) {
                  result = LoginScreen();
                }
              }
              return result;
            }));
  }
}
