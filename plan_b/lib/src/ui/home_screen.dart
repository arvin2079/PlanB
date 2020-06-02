import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/homeTabs/doneProject_tab.dart';
import 'package:planb/src/ui/homeTabs/goingProject_tab.dart';
import 'package:planb/src/ui/homeTabs/todoProject_tab.dart';
import 'package:planb/src/ui/uiComponents/round_icon_avatar.dart';

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
        endDrawer: SafeArea(
          child: Drawer(
            child: Container(
              color: primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40, horizontal:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("نام", textDirection: TextDirection.rtl, textAlign: TextAlign.right, style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white),),
                            SizedBox(height: 10,),
                            Text("نام خانوادگی", textDirection: TextDirection.rtl, textAlign: TextAlign.right, style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white),)
                          ],
                        ),
                        SizedBox(width: 20,),
                        CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                              child: Image.asset(
                                "images/noImage.png",
                                fit: BoxFit.cover,
                                width: 95.0,
                                height: 95.0,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildListTile("پروژه جدید", Icons.insert_drive_file),
                  _buildListTile("پروفایل", Icons.person),
                  _buildListTile("درباره ما", Icons.info_outline),
                ],
              ),
            ),
          ),
        ),
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

  Widget _buildSolidCircle(double radius, Color color) {
    return ClipOval(
      child: Container(
        width: radius*2,
        height: radius*2,
        color: color,
      ),
    );
  }
  Widget _buildListTile(String title, IconData iconData){
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: ListTile(
          onTap: (){},
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(title, textDirection: TextDirection.rtl, textAlign: TextAlign.right, style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white),),
          trailing: Icon(iconData, color: Colors.white,),
        ),
      ),
    );
  }
}