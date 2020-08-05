import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/model/skill_model.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/resume_screen.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';
import 'package:planb/src/ui/uiComponents/simple_user_button.dart';

List requestedSkills;
List allUserSKills;

class ProjectSearchDelegate extends SearchDelegate {
  SkillRepository _skillRepository;

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.tune),
        onPressed: () {
          userBloc.getCompleteProfileFields();
          _buildSkillRepository();
          showDialog(
              context: context,
              child: AlertDialog(
                  title: Text(
                    "انتخاب بر اساس مهارت های شما",
                    textAlign: TextAlign.right,
                  ),
                  scrollable: true,
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                          child: Row(
                            children: <Widget>[
                              Text(
                                'ادامه',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                  content: StreamBuilder(
                      stream: userBloc.userInfoStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          User user = snapshot.data;
                          if (requestedSkills == null) {
                            requestedSkills = user.skillCodes;
                          }
                          allUserSKills = user.skillCodes;
                          return Container(
                            width: 300.0,
                            child: ChipWrapper(_skillRepository),
                          );
                        }
                        return LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                        );
                      })));
        },
      ),
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    projectBloc.searchProject(requestedSkills);
    return StreamBuilder(
        stream: projectBloc.searchedProjectStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Project> projects = snapshot.data;
            if(projects.isEmpty){
              return _buildNoResult(context);
            }
            return ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return ProjectCard(
                    item: projects[index],
                    context: context,
                    skillRepository: _skillRepository,
                  );
                });
          }
          if (requestedSkills == null || requestedSkills.isEmpty) {
            return _buildNoResult(context);
          }
          return LinearProgressIndicator();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _buildNoResult(context);
    }
    return buildResults(context);
  }

  Widget _buildNoResult(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/no_result_project.png",
              fit: BoxFit.fitWidth,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "!نتیجه ای یافت نشد\nاز انتخاب مهارت های مورد نظرت مطمئن شو",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildSkillRepository() {
    userBloc.skillsStream.first.then((value) {
      if (value != null) {
        List<Skill> _skillObjects = [];
        for (int i = 0; i < value.length; i++) {
          Skill skill = Skill.fromJson(value[i]);
          _skillObjects.add(skill);
        }
        _skillRepository = SkillRepository(skills: _skillObjects);
      }
    });
  }
}

class ChipWrapper extends StatefulWidget {
  final SkillRepository skillRepository;

  ChipWrapper(this.skillRepository);

  @override
  _ChipWrapperState createState() => _ChipWrapperState(skillRepository);
}

class _ChipWrapperState extends State<ChipWrapper> {
  SkillRepository skillRepository;
  List permanentUserSkills = [];

  _ChipWrapperState(this.skillRepository);

  @override
  void initState() {
    allUserSKills.forEach((element) {
      permanentUserSkills.add(element);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: SingleChildScrollView(
        child: Wrap(
          children: _buildChipList(),
          spacing: 10.0,
        ),
      ),
    );
  }

  _buildChipList() {
    List<Widget> list = [];
    for (var item in permanentUserSkills) {
      bool _isDeleted = !requestedSkills.contains(item);
      Chip ch = Chip(
        onDeleted: () {
          setState(() {
            if (_isDeleted) {
              requestedSkills.add(item);
            } else {
              requestedSkills.remove(item);
            }
          });
        },
        label: Text(skillRepository.findSkillNameByCode(item)),
        backgroundColor: _isDeleted ? Colors.grey : Colors.lightBlue,
        deleteIcon: Icon(
          _isDeleted ? Icons.add_circle_outline : Icons.remove_circle_outline,
          size: 20,
        ),
      );
      list.add(ch);
    }
    return list;
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
            style: Theme.of(context).textTheme.subtitle,
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
              name: (item.users[index]).toString().split(" ").first,
              lastname: (item.users[index]).toString().split(" ").last,
              trailingIcon: Icon(Icons.group, color: Colors.white, size: 150),
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
        RaisedButton(
          child:
              Text('درخواست مشارکت', style: Theme.of(context).textTheme.button),
          onPressed: () {
            projectBloc.corporateRequest(item.id);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                "...در حال ارسال درخواست",
                textAlign: TextAlign.right,
              ),
            ));
          },
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
