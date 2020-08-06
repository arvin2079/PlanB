import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/model/skill_model.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/uiComponents/offline_error.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';
import 'package:planb/src/ui/uiComponents/simple_user_button.dart';

import '../resume_screen.dart';

class DoneProjectsTabTakePart extends StatefulWidget {
  SkillRepository skillRepository;

  DoneProjectsTabTakePart(this.skillRepository);

  @override
  _DoneProjectsTabTakePartState createState() =>
      _DoneProjectsTabTakePartState();
}

class _DoneProjectsTabTakePartState extends State<DoneProjectsTabTakePart> {
  @override
  void initState() {
    projectBloc.getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: projectBloc.projectStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                child: Column(
                  children: _buildProjectCards(snapshot.data),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return OfflineError(
              function: (){projectBloc.getProjects();},
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  List<Widget> _buildProjectCards(items) {
    List<Widget> _result = [];

    for (Project item in items) {
      ProjectCard card = ProjectCard(
        item: item,
        context: context,
        skillRepository: widget.skillRepository,
      );
      _result.add(card);
    }
    if (_result == null || _result.isEmpty) {
      _result.add(Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Text(
          "!پروژه ای یافت نشد",
          style: Theme.of(context).textTheme.headline1,
        ),
      ));
    }
    return _result;
  }

  Future<void> _refresh() async {
    await projectBloc.getProjects();
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard(
      {@required this.item, @required this.context, this.skillRepository});

  final Project item;
  final BuildContext context;
  final SkillRepository skillRepository;

  @override
  Widget build(BuildContext context) {
    return AbstractProjectCard(
      title: item.name,
      caption: item.descriptions,
      buttonOpenText: 'جزئیات',
      children: <Widget>[
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'مهارت ها',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Wrap(
          children: _buildSkillChips(
              skillCodes: item.skillCodes, skillRepository: skillRepository),
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
          itemCount: item.users.length,
          itemBuilder: (context, index) {
            return CustomButton(
              leftColor: button1Color,
              rightColor: primaryColor,
              name: (item.users[index].firstName),
              lastname: (item.users[index]).lastName,
              trailingIcon: Icon(Icons.group, color: Colors.white, size: 150),
              showArrow: true,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ResumeScreen(
                          id: item.users[index].id,
                          skillRepository: skillRepository,
                        )));
              },
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
          name: item.creator.firstName,
          lastname: item.creator.lastName,
          trailingIcon: Icon(Icons.group, color: Colors.white, size: 150),
          showArrow: true,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ResumeScreen(
                      id: item.creator.id,
                      skillRepository: skillRepository,
                    )));
          },
        ),
        SizedBox(height: 15),
      ],
    );
  }

  _buildSkillChips({List skillCodes, SkillRepository skillRepository}) {
    List<Widget> result = [];
    for (int i in skillCodes) {
      result.add(Chip(
        label: Text(skillRepository.findSkillNameByCode(i)),
      ));
      result.add(SizedBox(
        width: 5,
      ));
    }
    if (result == null) {
      result.add(Center(
        child: Text(""),
      ));
    }
    return result;
  }
}

class OthersViewProjectCard extends StatelessWidget {
  const OthersViewProjectCard({
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
            style: Theme.of(context).textTheme.headline3,
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
          child: Text('انصراف', style: Theme.of(context).textTheme.button),
          onPressed: () {},
        )
      ],
    );
  }
}
