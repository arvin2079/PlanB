import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';
import 'package:planb/src/ui/uiComponents/simple_user_button.dart';

class SearchProjectTab extends StatefulWidget {
  @override
  _SearchProjectTabState createState() => _SearchProjectTabState();
}

class _SearchProjectTabState extends State<SearchProjectTab> {
  List<ProjectItem> _todoProjectsTabList = <ProjectItem>[

  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            textDirection: TextDirection.rtl,
            showCursor: true,
            style: Theme.of(context).textTheme.headline1.copyWith(
              color: Colors.white,
            ),
            keyboardType: TextInputType.text,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _getProjectCards.toList(),
          ),
        ),
      ],
    );
  }

  Iterable<Widget> get _getProjectCards sync* {
    for (ProjectItem item in _todoProjectsTabList) {
      yield SearchViewProjectCard(context: context, item: item);
    }
  }
}

class SearchViewProjectCard extends StatelessWidget {
  const SearchViewProjectCard({
    @required this.item,
    @required this.context,
  });

  final ProjectItem item;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AbstractProjectCard(
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
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: item.team.length,
          itemBuilder: (context, index) {
            return CustomButton(
              leftColor: button1Color,
              rightColor: primaryColor,
              name: item.team[index].name,
              lastname: item.team[index].lastname,
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
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        CustomButton(
          leftColor: button1Color,
          rightColor: primaryColor,
          name: item.creator.name,
          lastname: item.creator.lastname,
          trailingIcon: Icon(Icons.group, color: Colors.white, size: 150),
          showArrow: true,
        ),
        SizedBox(height: 15),
        RaisedButton(
          child: Text('اعلام همکاری', style: Theme.of(context).textTheme.button),
          onPressed: (){},
        )
      ],
    );
  }
}

