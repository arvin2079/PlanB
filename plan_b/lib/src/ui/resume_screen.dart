import 'package:flutter/material.dart';
import 'package:planb/src/ui/uiComponents/drawer.dart';
import 'constants/constants.dart';

class ResumeScreen extends StatelessWidget {
  ResumeScreen({this.onNavButtTab});

  final Function onNavButtTab;

  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: HomeDrawer(),
      appBar: AppBar(
        title: Text(
          'رزومه',
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
      body: Center(
        child: Text('jostojoo afrad'),
      ),
    );
  }
}
