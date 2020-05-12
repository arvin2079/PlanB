import 'package:flutter/material.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';

class DoneProjectsTab extends StatefulWidget {

  // fixme : pass the list of items from home or each tab get its own items
//  const DoneProjectsTab({this._doneProjectsTabList});
//  final List<ProjectItem> _doneProjectsTabList;

  @override
  _DoneProjectsTabState createState() => _DoneProjectsTabState();
}

class _DoneProjectsTabState extends State<DoneProjectsTab> {
  List<ProjectItem> _doneProjectsTabList = <ProjectItem>[
    ProjectItem(
      name: 'پروژه اول شما',
      caption: 'اینجا توضیح کوتاهی درمورد اولین پروژه شما نوشته خواهد شد',
      skills: <String>[
        'اندروید',
        'جاوا',
        'وزنه برداری',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // todo : create itrable to create a list of widgets for children (using project items)
//        children: _doneProjectsTabList,
      ),
    );
  }
}

