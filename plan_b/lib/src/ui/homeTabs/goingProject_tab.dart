import 'package:flutter/material.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';

class GoingProjectsTab extends StatefulWidget {
  @override
  _GoingProjectsTabState createState() => _GoingProjectsTabState();
}

class _GoingProjectsTabState extends State<GoingProjectsTab> {
  List<ProjectItem> _goingProjectsTabList = <ProjectItem>[];

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
    for (ProjectItem item in _goingProjectsTabList) {
      yield ProjectCard(
        title: item.title,
        caption: item.caption,
        buttonOpenText: 'مدیریت',
      );
    }
  }
}
