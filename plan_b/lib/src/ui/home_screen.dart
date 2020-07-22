import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/ui/project_screen.dart';
import 'package:planb/src/ui/resume_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'newProject_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selected = 0;
  int id;
  List<Widget> _tabs;

  @override
  void initState() {
    userBloc.getCompleteProfileFields();
    _getUserId();
    _tabs = [
      ProjectScreen(),
      NewProjectScreen(),
      FutureBuilder(
        future: _getUserId(),
        builder: (context, snapshot) {
          return ResumeScreen(
            id: id,
          );
        },
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selected],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onNavButtSelected,
        currentIndex: _selected,
        backgroundColor: Colors.white,
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

  _getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getInt('id');
  }
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
