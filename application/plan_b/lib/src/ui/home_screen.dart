import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:planb/src/ui/homeTabs/doneProject_tab.dart';
import 'package:planb/src/ui/homeTabs/goingProject_tab.dart';
import 'package:planb/src/ui/homeTabs/todoProject_tab.dart';

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
          title: Text(
            'PlanB',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              _buildTabName(context, 'انجام شده'),
              _buildTabName(context, 'درحال انجام'),
              _buildTabName(context, 'برای انجام'),
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

  Padding _buildTabName(BuildContext context, String name) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        name,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}