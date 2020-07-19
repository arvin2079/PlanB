import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/ui/project_search_delegate.dart';
import 'package:planb/src/ui/user_search_delegate.dart';

import 'constants/constants.dart';
import 'homeTabs/doneProject_tab_created.dart';
import 'homeTabs/doneProject_tab_takePart.dart';
import 'homeTabs/searchProject_tab.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen({this.onNavButtTab});
  final Function onNavButtTab;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'پروژه ها',
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){showSearch(context: context, delegate: UserSearchDelegate());},
            ),
          ],
          bottom: TabBar(
            indicatorColor: secondaryColor,
            indicatorWeight: 5,
            isScrollable: false,
            tabs: <Widget>[
              _buildTabName(context, 'ایجادشده‌ها'),
              _buildTabName(context, 'مشارکت‌ها'),
              _buildTabName(context, 'جستجو'),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.business_center),
              title: Text('پروژه ها',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: 15,
                  )),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('جست جو افراد',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: 15,
                  )),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_drive_file),
              title: Text('رزومه',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: 15,
                  )),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          onTap: (int index) {
            onNavButtTab(index);
          },
        ),
        body: TabBarView(
          children: <Widget>[
            DoneProjectsTabCreated(),
            DoneProjectsTabTakePart(),
            SearchProjectTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed('/new_project');
          },
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
