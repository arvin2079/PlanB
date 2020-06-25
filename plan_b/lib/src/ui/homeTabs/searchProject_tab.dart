import 'package:flutter/material.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';

class SearchProjectTab extends StatefulWidget {
  @override
  _SearchProjectTabState createState() => _SearchProjectTabState();
}

class _SearchProjectTabState extends State<SearchProjectTab> {
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
