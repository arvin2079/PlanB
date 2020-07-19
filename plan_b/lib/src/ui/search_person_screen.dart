import 'package:flutter/material.dart';

import 'constants/constants.dart';

class SearchPersonScreen extends StatelessWidget {
  SearchPersonScreen({this.onNavButtTab});
  final Function onNavButtTab;

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'جست و جو افراد',
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
