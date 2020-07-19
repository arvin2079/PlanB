import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/bloc/authenticatin_bloc.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawer extends StatelessWidget {
  String firstName, lastName;

  static final HomeDrawer _instance = HomeDrawer._singleton();

  HomeDrawer._singleton();

  factory HomeDrawer() {
    return _instance;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserInfoFromSharedPreferences(),
      builder: (context, snapshot) {
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
                              firstName != null && firstName.isNotEmpty ? firstName : 'first name',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              lastName != null && lastName.isNotEmpty ? lastName : 'last name',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.headline5,
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
                  _buildListTile(context,"پروفایل", Icons.person, '/edit_profile'),
                  _buildListTile(context, "درباره ما", Icons.info_outline, '/home'),
                  _buildListTile(context, "خروج", Icons.exit_to_app, '/login'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListTile(BuildContext context, String title, IconData iconData, String destinationPath) {
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
          title: Text(title,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w100)),
          trailing: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _getUserInfoFromSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    firstName = sharedPreferences.getString('firstName');
    lastName = sharedPreferences.getString('lastName');
  }
}
