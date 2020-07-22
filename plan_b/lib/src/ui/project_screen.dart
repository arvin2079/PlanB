import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/ui/project_search_delegate.dart';
import 'package:planb/src/ui/uiComponents/drawer.dart';
import 'package:planb/src/ui/user_search_delegate.dart';
import 'constants/constants.dart';
import 'homeTabs/doneProject_tab_created.dart';
import 'homeTabs/doneProject_tab_takePart.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen({this.onNavButtTab});
  final Function onNavButtTab;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FabCircularMenu(
          fabColor: secondaryColor,
          fabCloseIcon: Icon(Icons.close, color: Colors.white),
          fabOpenIcon: Icon(Icons.search, color: Colors.white),
          fabCloseColor: secondaryColor,
          fabOpenColor: secondaryColor.withOpacity(0.7),
          fabMargin: EdgeInsets.only(right: 35, bottom: 30),
          ringColor: Colors.black12,
          ringDiameter: 400,
          children: <Widget>[
            RaisedButton.icon(
              label: Text('افراد' , style: Theme.of(context).textTheme.button),
              icon: Icon(Icons.perm_identity, color: Colors.white),
              onPressed: (){
                showSearch(context: context, delegate: UserSearchDelegate());
              },
            ),
            RaisedButton.icon(
              label: Text('پروژه ها', style: Theme.of(context).textTheme.button),
              icon: Icon(Icons.description, color: Colors.white),
              onPressed: (){
                showSearch(context: context, delegate: ProjectSearchDelegate());

              },
            ),
          ],
        ),
        endDrawer: HomeDrawer(),
        appBar: AppBar(
          title: Text(
            'پروژه ها',
          ),
          bottom: TabBar(
            indicatorColor: secondaryColor,
            indicatorWeight: 5,
            isScrollable: false,
            tabs: <Widget>[
              _buildTabName(context, 'ایجادشده‌ها'),
              _buildTabName(context, 'مشارکت‌ها'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DoneProjectsTabCreated(),
            DoneProjectsTabTakePart(),
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
        style: TextStyle(
          fontFamily: 'yekan',
          fontSize: 16,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }
}
