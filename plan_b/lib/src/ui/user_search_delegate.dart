import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/model/skill_model.dart';
import 'package:planb/src/model/user_model.dart';

List requestedSkills;

class UserSearchDelegate extends SearchDelegate {
  SkillRepository _skillRepository;

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showResults(context);
        },
      ),
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
      )
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

          return ListView(
            children: <Widget>[
              Placeholder(),
            ],
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _buildNoResult(context);
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildNoResult(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("images/no_result_person.png"),
          Text(
            "!نتیجه ای یافت نشد",
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
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
    requestedSkills = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
        children: _buildChipList(),
        spacing: 10.0,
      ),
    );
  }

  _buildChipList() {
    List<Widget> list = [];
    for (var item in skillRepository.getCodes()) {
      bool _isDeleted =
          !requestedSkills.contains(item);
      Chip ch = Chip(
        onDeleted: () {
          setState(() {
            if (_isDeleted) {
              if(!requestedSkills.contains(item)){
                requestedSkills.add(item);
              }
              print(requestedSkills);

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
