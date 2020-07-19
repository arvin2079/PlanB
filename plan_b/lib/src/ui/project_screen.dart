import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/ui/uiComponents/drawer.dart';
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
          fabOpenIcon: Icon(Icons.bubble_chart, color: Colors.white),
          fabCloseColor: secondaryColor,
          fabOpenColor: secondaryColor.withOpacity(0.7),
          fabElevation: 0,
          fabMargin: EdgeInsets.only(right: 35, bottom: 30),
          ringColor: Colors.black12,
          ringDiameter: 400,
          children: <Widget>[
            RaisedButton.icon(
              label: Text('افراد' , style: Theme.of(context).textTheme.button),
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: (){},
            ),
            RaisedButton.icon(
              label: Text('پروژه ها', style: Theme.of(context).textTheme.button),
              icon: Icon(Icons.insert_drive_file, color: Colors.white),
              onPressed: (){},
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
              icon: Icon(Icons.control_point),
              title: Text('ایجاد پروژه',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: 15,
                  )),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_file),
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
