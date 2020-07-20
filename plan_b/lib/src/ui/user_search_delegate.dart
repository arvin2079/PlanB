import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/model/skill_model.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/uiComponents/simple_user_button.dart';

List requestedSkills = [];

class UserSearchDelegate extends SearchDelegate {
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
          buildResults(context);
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
    print(requestedSkills);
    if(requestedSkills == null){
      return _buildNoResult(context);
    }
    projectBloc.searchUser(requestedSkills);
    return StreamBuilder<List<User>>(
        stream: projectBloc.searchedUserStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> users = snapshot.data;
            if (users.isEmpty) {
              return _buildNoResult(context);
            }
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: CustomButton(
                      leftColor: secondaryColor,
                      rightColor: secondaryVariant,
                      name: users[index].firstName,
                      lastname: users[index].lastName,
                      trailingIcon: Icon(Icons.search,
                          color: Colors.white, size: 150),
                      showArrow: false,
                      onPressed: () {},
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
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
            Image.asset("images/no_result_person.png", fit: BoxFit.fitWidth,),
            Container(
              width: MediaQuery.of(context).size.width *4/5,
              child: Text(
                "!نتیجه ای یافت نشد\nاز درست بودن عبارت جستجو شده و مهارت های انتخاب شده مورد نظرت مطمئن شو",
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
      bool _isDeleted = !requestedSkills.contains(item);
//      print(skillRepository.findSkillNameByCode(item) + "  " + _isDeleted.toString()  + "\n");
      Chip ch = Chip(
        onDeleted: () {
          setState(() {
            if (_isDeleted) {
              if (!requestedSkills.contains(item)) {
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
