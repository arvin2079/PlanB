import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        endDrawer: Drawer(),
        appBar: AppBar(
          title: Text('PlanB'),
          bottom: TabBar(
            tabs: <Widget>[
              Text('انجام شده'),
              Text('درحال انجام'),
              Text('انجام شده'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DoneProjectsTab(),
            GoingProjectsTab(),
            TodoProjectsTab(),
          ],
        ),
      ),
    );
  }
}

class DoneProjectsTab extends StatefulWidget {
  @override
  _DoneProjectsTabState createState() => _DoneProjectsTabState();
}

class _DoneProjectsTabState extends State<DoneProjectsTab> {
  List<Widget> _doneProjectsTabList = <Widget>[
    ProjectCard(
      buttonOpenText: 'جزئیات',
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          'پروژه شماره یک',
          style: TextStyle(color: Colors.black, fontFamily: 'yekan', fontSize: 20),
        ),
      ),
      subtitle: Text(
        'سلام و درود بر همگان که اینحا سلام و درودبازم سلام بر همگان که اینحا سلام و درود بر هبازم سلاممگان که اینحا سلام بازم سلامو درود بر همگان که اینحا سلام و درود بر هبازم سلاممگان که اینحا سلام و درود بر همگان که اینحا',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'yekan',
          fontSize: 15,
          height: 1.3
        ),
      ),
      children: <Widget>[
        Text(
          'پروژه شماره یک',
          style: TextStyle(color: Colors.black, fontFamily: 'yekan'),
        ),
        Text(
          'پروژه شماره یک',
          style: TextStyle(color: Colors.black, fontFamily: 'yekan'),
        ),
        Text(
          'پروژه شماره یک',
          style: TextStyle(color: Colors.black, fontFamily: 'yekan'),
        ),
        Text(
          'پروژه شماره یک',
          style: TextStyle(color: Colors.black, fontFamily: 'yekan'),
        ),
        Text(
          'پروژه شماره یک',
          style: TextStyle(color: Colors.black, fontFamily: 'yekan'),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _doneProjectsTabList,
      ),
    );
  }
}

class GoingProjectsTab extends StatefulWidget {
  @override
  _GoingProjectsTabState createState() => _GoingProjectsTabState();
}

class _GoingProjectsTabState extends State<GoingProjectsTab> {
  List<Widget> _goingProjectsTabList = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _goingProjectsTabList,
      ),
    );
  }
}

class TodoProjectsTab extends StatefulWidget {
  @override
  _TodoProjectsTabState createState() => _TodoProjectsTabState();
}

class _TodoProjectsTabState extends State<TodoProjectsTab> {
  List<Widget> _todoProjectsTabList = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _todoProjectsTabList,
      ),
    );
  }
}

//class ProjectItem {
//  final String projectName;
//  final String projectCaption;
//  final List<String> team;
//  final List<String>
//}
