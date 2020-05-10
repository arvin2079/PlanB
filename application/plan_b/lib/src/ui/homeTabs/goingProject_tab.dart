import 'package:flutter/material.dart';

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