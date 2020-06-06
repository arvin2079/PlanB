import 'package:flutter/material.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';
import 'package:planb/src/ui/uiComponents/resumeButton.dart';

class DoneProjectsTab extends StatefulWidget {
  // fixme : pass the list of items from home or each tab get its own items
//  const DoneProjectsTab({this._doneProjectsTabList});
//  final List<ProjectItem> _doneProjectsTabList;

  @override
  _DoneProjectsTabState createState() => _DoneProjectsTabState();
}

class _DoneProjectsTabState extends State<DoneProjectsTab> {
  List<ProjectItem> _doneProjectsTabList = <ProjectItem>[
    // example
//    ProjectItem(
//      title: 'پروژه اول شما',
//      caption: 'اینجا توضیح کوتاهی درمورد اولین پروژه شما نوشته خواهد شد',
//      skills: <String>[
//        'اندروید',
//        'جاوا',
//        'وزنه برداری',
//      ],
//    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _getProjectCards.toList(),
      ),
    );
  }

  Iterable<Widget> get _getProjectCards sync* {
    for (ProjectItem item in _doneProjectsTabList) {
      yield ProjectCard(
        title: item.title,
        caption: item.caption,
        buttonOpenText: 'جزئیات',
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'مهارت ها',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          Wrap(
            children: item.skills.map<Widget>((String skill) {
              return Padding(
                padding: EdgeInsets.all(3),
                child: Chip(
                  label: Text(
                    skill,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'تیم این پروژه',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          ListView.builder(
            itemCount: item.team.length,
            itemBuilder: (context, index) {
              return CustomButton(
                leftColor: button1Color,
                rightColor: primaryColor,
                name: item.team[index].name,
                lastName: item.team[index].lastName,
                trailingIcon: Icon(Icons.group, color: Colors.white, size: 150),
                showArrow: true,
              );
            },
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'سازنده',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          CustomButton(
            leftColor: button1Color,
            rightColor: primaryColor,
            name: item.creator.name,
            lastName: item.creator.lastName,
            trailingIcon: Icon(Icons.group, color: Colors.white, size: 150),
            showArrow: true,
          ),
        ],
      );
    }
  }
}
