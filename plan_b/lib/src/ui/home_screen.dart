import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/bloc/authenticatin_bloc.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/homeTabs/doneProject_tab_created.dart';
import 'package:planb/src/ui/homeTabs/doneProject_tab_takePart.dart';
import 'package:planb/src/ui/homeTabs/searchProject_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String firstName, lastName;

  @override
  void initState() {
    userBloc.getCompleteProfileFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        endDrawer: _buildEndDrawer(),
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
//              _buildTabName(context, 'در حال انجام'),
              _buildTabName(context, 'جستجو'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DoneProjectsTabCreated(),
            DoneProjectsTabTakePart(),
//            GoingProjectsTab(),
            SearchProjectTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
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

  Widget _buildSolidCircle(double radius, Color color) {
    return ClipOval(
      child: Container(
        width: radius * 2,
        height: radius * 2,
        color: color,
      ),
    );
  }

  Widget _buildListTile(
      String title, IconData iconData, String destinationPath) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: ListTile(
          onTap: () {
            if (destinationPath == '/login') {
              authenticationBloc.logOut();
            }
            Navigator.pushNamed(context, destinationPath);
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            title,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w100
            )
          ),
          trailing: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _buildEndDrawer() {
        return FutureBuilder(
          future: _getUserInfoFromSharedPreferences(),
          builder: (context, snapshot){
            return SafeArea(
              child: Drawer(
                child: Container(
                  color: primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  firstName,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  lastName,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            CircleAvatar(
                              radius: 50,
                              child: ClipOval(
                                  child: Image.asset(
                                    "images/noImage.png",
                                    fit: BoxFit.cover,
                                    width: 95.0,
                                    height: 95.0,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      _buildListTile("پروفایل", Icons.person, '/edit_profile'),
                      _buildListTile("درباره ما", Icons.info_outline, '/home'),
                      _buildListTile("خروج", Icons.exit_to_app, '/login'),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }

  _getUserInfoFromSharedPreferences() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    firstName = sharedPreferences.getString('firstName');
    lastName = sharedPreferences.getString('lastName');
  }
}
