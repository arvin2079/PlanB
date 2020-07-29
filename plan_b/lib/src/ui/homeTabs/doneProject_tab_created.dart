import 'package:flutter/material.dart';
import 'package:planb/src/bloc/dsd_project_bloc.dart';
import 'package:planb/src/model/dsd_project_model.dart';
import 'package:planb/src/model/skill_model.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/resume_screen.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';
import 'package:planb/src/ui/uiComponents/request_user_button.dart';
import 'package:planb/src/ui/uiComponents/simple_user_button.dart';

class DoneProjectsTabCreated extends StatefulWidget {
  SkillRepository skillRepository;

  DoneProjectsTabCreated(this.skillRepository);

  @override
  _DoneProjectsTabCreatedState createState() => _DoneProjectsTabCreatedState();
}

class _DoneProjectsTabCreatedState extends State<DoneProjectsTabCreated> {
  @override
  void initState() {
    dsdProjectBloc.getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dsdProjectBloc.getProjects();
    return StreamBuilder(
        stream: dsdProjectBloc.projectStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: _buildProjectCards(snapshot.data),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  List<Widget> _buildProjectCards(items) {
    List<Widget> _result = [];

    for (DSDProject item in items) {
      CreatorViewProjectCard card = CreatorViewProjectCard(
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
}

class CreatorViewProjectCard extends StatelessWidget {
  CreatorViewProjectCard({
    @required this.item,
    @required this.context,
    @required this.skillRepository,
  });

  final DSDProject item;
  final ProjectItem item2 = null;
  final BuildContext context;
  final SkillRepository skillRepository;

  @override
  Widget build(BuildContext context) {
    return AbstractProjectCard(
      title: item.project.name,
      caption: item.project.descriptions,
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
              skillCodes: item.project.skillCodes,
              skillRepository: skillRepository),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'تیم این پروژه',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        item.users != null && item.users.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: item.users.length,
                itemBuilder: (context, index) {
                  return CustomButton(
                    leftColor: button1Color,
                    rightColor: primaryColor,
                    name: item.users[index].user.firstName,
                    lastname: item.users[index].user.lastName,
                    trailingIcon:
                        Icon(Icons.group, color: Colors.white, size: 150),
                    showArrow: true,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResumeScreen(
                                id: item.users[index].user.id,
                                skillRepository: skillRepository,
                              )));
                    },
                  );
                },
              )
            : Text(
                'هیچ کاربری پیدا نشد!',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.grey[500]),
              ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'درخواست های همکاری',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        item.cooperation != null && item.cooperation.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: item.cooperation.length,
                itemBuilder: (context, index) {
                  return RequestUserButton(
                    leftColor: green2Color,
                    rightColor: green1Color,
                    name: item.cooperation[index].user.firstName,
                    lastname: item.cooperation[index].user.lastName,
                    trailingIcon:
                        Icon(Icons.group, color: Colors.white, size: 150),
                    onReject: () {
                      int projectId = (item.project.id);
                      int cooperId = (item.cooperation[index].id);
                      dsdProjectBloc.manageUserRequest(
                          projectId, cooperId, false);
                    },
                    onAccept: () {
                      int projectId = (item.project.id);
                      int cooperId = (item.cooperation[index].id);
                      dsdProjectBloc.manageUserRequest(
                          projectId, cooperId, true);
                    },
                  );
                },
              )
            : Text(
                'هیچ درخواستی ثبت نشده!',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.grey[500]),
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
          name: item.project.creator.firstName,
          lastname: item.project.creator.lastName,
          trailingIcon: Icon(Icons.group, color: Colors.white, size: 150),
          showArrow: true,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ResumeScreen(
                      id: item.project.creator.id,
                      skillRepository: skillRepository,
                    )));
          },
        ),
        SizedBox(height: 15),
        RaisedButton(
          child: Text('اتمام پروژه', style: Theme.of(context).textTheme.button),
          onPressed: () {},
        )
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
