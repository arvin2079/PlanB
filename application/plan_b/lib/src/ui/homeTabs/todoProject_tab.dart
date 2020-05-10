import 'package:flutter/material.dart';

class TodoProjectsTab extends StatefulWidget {
  @override
  _TodoProjectsTabState createState() => _TodoProjectsTabState();
}

class _TodoProjectsTabState extends State<TodoProjectsTab> {
  List<Widget> _todoProjectsTabList = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _todoProjectsTabList,
      ),
    );
  }
}