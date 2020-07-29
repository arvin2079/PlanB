import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/skill_model.dart';
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
  SkillRepository _skillRepository;

  @override
  void initState() {
    userBloc.getCompleteProfileFields();
    _buildSkillRepository();
    _getUserId();
    _tabs = [
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userBloc.getCompleteProfileFields();
    _initializeTabs();
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

  _buildSkillRepository() {
    userBloc.skillsStream.first.then((value) {
      if (value != null) {
        List<Skill> _skillObjects = [];
        for (int i = 0; i < value.length; i++) {
          Skill skill = Skill.fromJson(value[i]);
          _skillObjects.add(skill);
        }
        _skillRepository = SkillRepository(skills: _skillObjects);
      }
    });
  }

  void _initializeTabs() async{
    _tabs.add(
        StreamBuilder(
            stream: userBloc.skillsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ProjectScreen(
                  skillRepository: _skillRepository,
                );
              }
              return Center(child: CircularProgressIndicator());
            }
        )
    );
    _tabs.add(NewProjectScreen());
    _tabs.add(FutureBuilder(
      future: _getUserId(),
      builder: (context, snapshot) {
        return StreamBuilder(
            stream: userBloc.skillsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ResumeScreen(
                  id: id,
                  skillRepository: _skillRepository,
                );
              }
              return Center(child: CircularProgressIndicator());
            });
      },
    ));
  }
}
