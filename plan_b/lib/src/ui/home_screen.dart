import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/ui/project_screen.dart';
import 'package:planb/src/ui/resume_screen.dart';

import 'newProject_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selected = 0;

  @override
  void initState() {
    userBloc.getCompleteProfileFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_selected == 0)
      return ProjectScreen(onNavButtTab: onNavButtSelected);
    if(_selected == 1)
      return NewProjectScreen(onNavButtTab: onNavButtSelected);
    return ResumeScreen(onNavButtTab: onNavButtSelected);
  }

  void onNavButtSelected(int index) {
    setState(() {
      _selected = index;
    });
  }

//  Widget _buildSolidCircle(double radius, Color color) {
//    return ClipOval(
//      child: Container(
//        width: radius * 2,
//        height: radius * 2,
//        color: color,
//      ),
//    );
//  }
}
