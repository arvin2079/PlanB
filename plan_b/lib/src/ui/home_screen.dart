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
  List<Widget> _tabs = [ProjectScreen(), NewProjectScreen(), ResumeScreen()];

  @override
  void initState() {
    userBloc.getCompleteProfileFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selected],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onNavButtSelected,
        currentIndex: _selected,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            title: Text('پروژه ها',
                style: TextStyle(
                  fontFamily: 'vazir',
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.control_point),
            title: Text('ایجاد پروژه',
                style: TextStyle(
                  fontFamily: 'vazir',
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_file),
            title: Text('رزومه',
                style: TextStyle(
                  fontFamily: 'vazir',
                )),
          ),
        ],
      ),
    );
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
