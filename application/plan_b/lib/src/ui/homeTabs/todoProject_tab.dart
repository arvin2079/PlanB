import 'package:flutter/material.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';

class TodoProjectsTab extends StatefulWidget {
  @override
  _TodoProjectsTabState createState() => _TodoProjectsTabState();
}

class _TodoProjectsTabState extends State<TodoProjectsTab> {
  List<ProjectItem> _todoProjectsTabList = <ProjectItem>[];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _getProjectCards.toList(),
      ),
    );
  }

  Iterable<Widget> get _getProjectCards sync* {
    for (ProjectItem item in _todoProjectsTabList) {
      yield ProjectCard(
        title: item.title,
        caption: item.caption,
        buttonOpenText: 'جزئیات',
        children: <Widget>[],
      );
    }
  }
}
