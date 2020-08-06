import 'package:flutter/cupertino.dart';
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
            return RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                child: Column(
                  children: _buildProjectCards(snapshot.data),
                ),
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
      if (item.project.activation) {
        CreatorViewProjectCard card = CreatorViewProjectCard(
          item: item,
          context: context,
          skillRepository: widget.skillRepository,
          onRebuild: () {
            setState(() {});
          },
        );
        _result.add(card);
      }
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
    await dsdProjectBloc.getProjects();
  }
}

class CreatorViewProjectCard extends StatefulWidget {
  CreatorViewProjectCard({
    @required this.item,
    @required this.context,
    @required this.skillRepository,
    this.onRebuild,
  });

  final DSDProject item;
  final BuildContext context;
  final SkillRepository skillRepository;
  final Function onRebuild;

  @override
  _CreatorViewProjectCardState createState() => _CreatorViewProjectCardState();
}

class _CreatorViewProjectCardState extends State<CreatorViewProjectCard> {
  @override
  Widget build(BuildContext context) {
    return AbstractProjectCard(
      title: widget.item.project.name,
      caption: widget.item.project.descriptions,
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
              skillCodes: widget.item.project.skillCodes,
              skillRepository: widget.skillRepository),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'تیم این پروژه',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        widget.item.users != null && widget.item.users.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: widget.item.users.length,
                itemBuilder: (context, index) {
                  return CustomButton(
                    leftColor: button1Color,
                    rightColor: primaryColor,
                    name: widget.item.users[index].user.firstName,
                    lastname: widget.item.users[index].user.lastName,
                    trailingIcon:
                        Icon(Icons.group, color: Colors.white, size: 150),
                    showArrow: true,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResumeScreen(
                                id: widget.item.users[index].user.id,
                                skillRepository: widget.skillRepository,
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
        widget.item.cooperation != null && widget.item.cooperation.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: widget.item.cooperation.length,
                itemBuilder: (context, index) {
                  return RequestUserButton(
                    leftColor: green2Color,
                    rightColor: green1Color,
                    name: widget.item.cooperation[index].user.firstName,
                    lastname: widget.item.cooperation[index].user.lastName,
                    trailingIcon:
                        Icon(Icons.group, color: Colors.white, size: 150),
                    onReject: () {
                      int projectId = (widget.item.project.id);
                      int cooperId = (widget.item.cooperation[index].id);
                      dsdProjectBloc.manageUserRequest(
                          projectId, cooperId, false);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                          '!درخواست رد شد',
                          textAlign: TextAlign.right,
                        ),
                        duration: Duration(milliseconds: 500),
                      ));
                      widget.onRebuild();
                    },
                    onAccept: () {
                      int projectId = (widget.item.project.id);
                      int cooperId = (widget.item.cooperation[index].id);
                      dsdProjectBloc.manageUserRequest(
                          projectId, cooperId, true);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                          '!درخواست تایید شد',
                          textAlign: TextAlign.right,
                        ),
                        duration: Duration(milliseconds: 500),
                      ));
                      widget.onRebuild();
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
        _buildCoopratorButton(context),
        SizedBox(height: 15),
        widget.item.project.activation
            ? RaisedButton(
                child: Text('اتمام پروژه',
                    style: Theme.of(context).textTheme.button),
                onPressed: () {
                  dsdProjectBloc.finishProject(widget.item.project.id);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'درخواست اتمام پروژه ارسال شد',
                      textAlign: TextAlign.right,
                    ),
                    duration: Duration(milliseconds: 500),
                  ));
                  widget.onRebuild();
                },
              )
            : RaisedButton(
                child: Text('پروژه به اتمام رسیده است',
                    style: Theme.of(context).textTheme.button),
              )
      ],
    );
  }

  Widget _buildCoopratorButton(BuildContext context) {
    return CustomButton(
      leftColor: button1Color,
      rightColor: primaryColor,
      name: widget.item.project.creator.firstName,
      lastname: widget.item.project.creator.lastName,
      trailingIcon: Icon(Icons.group, color: Colors.white, size: 150),
      showArrow: true,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ResumeScreen(
                  id: widget.item.project.creator.id,
                  skillRepository: widget.skillRepository,
                )));
      },
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
