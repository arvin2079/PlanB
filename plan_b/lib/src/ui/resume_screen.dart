import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/skill_model.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/ui/uiComponents/drawer.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';
import 'package:planb/src/ui/uiComponents/simple_user_button.dart';
import 'package:planb/src/ui/uiComponents/titleText.dart';

import 'constants/constants.dart';

class ResumeScreen extends StatefulWidget {
  final int id;

  ResumeScreen({this.id});

  @override
  _ResumeScreenState createState() => _ResumeScreenState(id: id);
}

class _ResumeScreenState extends State<ResumeScreen> {
  _ResumeScreenState({this.id});

  int id;
  SkillRepository _skillRepository;
  User user;

  @override
  void initState() {
    userBloc.getCompleteProfileFields();
    initializeItems();
    userBloc.getResume(id);
    super.initState();
    /*user2w = ResumeUserModel(
      firstname: 'عرفان',
      lastname: 'صبحایی',
      username: 'sobhaii_khatar',
      linkdin: 'linkdin_linkdin',
      email: 'sobhaii@khatar.balaa',
      studentCode: '123456789',
      projects: <ProjectItem>[
        ProjectItem(
          title: 'پروژه اول شما',
          caption: 'اینجا توضیح کوتاهی درمورد اولین پروژه شما نوشته خواهد شد',
          creator: User(
            'آتنا',
            'گنجی',
          ),
          team: <User>[
            User(
              'آروین',
              'صادقی',
            ),
            User(
              'عرفان',
              'صبحایی',
            ),
            User(
              'نیما',
              'پریفرد',
            ),
            User(
              'آروین',
              'صادقی',
            ),
            User(
              'عرفان',
              'صبحایی',
            ),
            User(
              'نیما',
              'پریفرد',
            ),
          ],
          skills: <String>[
            'اندروید',
            'جاوا',
            'وزنه برداری',
          ],
        ),
        ProjectItem(
          title: 'پروژه اول شما',
          caption: 'اینجا توضیح کوتاهی درمورد اولین پروژه شما نوشته خواهد شد',
          creator: User(
            'آتنا',
            'گنجی',
          ),
          team: <User>[
            User(
              'آروین',
              'صادقی',
            ),
            User(
              'عرفان',
              'صبحایی',
            ),
            User(
              'نیما',
              'پریفرد',
            ),
            User(
              'آروین',
              'صادقی',
            ),
            User(
              'عرفان',
              'صبحایی',
            ),
            User(
              'نیما',
              'پریفرد',
            ),
          ],
          skills: <String>[
            'اندروید',
            'جاوا',
            'وزنه برداری',
          ],
        ),
      ],
      skills: <String>[
        'flutter',
        'django',
        'python',
        'java',
      ],
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: HomeDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'رزومه',
        ),
      ),
      body: StreamBuilder(
        stream: userBloc.resumeStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            user = snapshot.data;
            return _buildScreenWidget();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildScreenWidget() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(height: 10),
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 48),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(12, 56, 12, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                            ),
                            Text(
                              "${user.firstName} ${user.lastName}",
                              textDirection: TextDirection.rtl,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "@" + user.username,
                              textDirection: TextDirection.ltr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                user.description,
                                textDirection: TextDirection.rtl,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 110,
                    decoration: ShapeDecoration(
                        shape: CircleBorder(), color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: DecoratedBox(
                        decoration: ShapeDecoration(
                            shape: CircleBorder(),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                //fixme: if user.avatar == null then use Image.Asset
                                image: user.avatar == null ? AssetImage('images/noImage.png') : NetworkImage(user.avatar))),
                      ),
                    ),
                  )
                ],
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TitleText(text: 'اطلاعات تماس'),
                      Text(
                        'ایمیل : ' + user.email,
                        textDirection: TextDirection.rtl,
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(fontSize: 18),
                      ),
                      user.instagram != null
                          ? Text(
                              'اینستاگرام : ' + user.instagram,
                              textDirection: TextDirection.rtl,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(fontSize: 18),
                            )
                          : Container(),
                      user.github != null
                          ? Text(
                              'گیت : ' + user.github,
                              textDirection: TextDirection.rtl,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(fontSize: 18),
                            )
                          : Container(),
                      user.telegram != null
                          ? Text(
                              'تلگرام : ' + user.telegram,
                              textDirection: TextDirection.rtl,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(fontSize: 18),
                            )
                          : Container(),
                      user.linkedIn != null
                          ? Text(
                              'لینکدین : ' + user.linkedIn,
                              textDirection: TextDirection.rtl,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(fontSize: 18),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TitleText(text: 'مهارت ها'),
                      Wrap(
                            children: _buildSkillChips(user.skillCodes)
                          ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Colors.black12,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TitleText(text: 'پروژه ها'),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black12,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  /*Iterable<Widget> get _getProjectCards sync* {
    for (ProjectItem item in user.projects) {
      yield FinishedProjectCard(item: item, context: context);
    }
  }*/

  void initializeItems() async {
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

  _buildSkillChips(List skillCodes){
    List<Widget> result = [];
    for (int i in skillCodes){
      result.add(Chip(label: Text(_skillRepository.findSkillNameByCode(i)),));
      result.add(SizedBox(width: 5,));
    }
    return result;
  }
}

class ResumeUserModel {
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String git;
  final String telegram;
  final String instagram;
  final String linkdin;
  final String studentCode;
  final List projects;
  final List<String> skills;

  ResumeUserModel(
      {this.git,
      this.telegram,
      this.instagram,
      this.linkdin,
      this.studentCode,
      this.email,
      this.username,
      this.firstname,
      this.lastname,
      this.projects,
      this.skills});
}

class FinishedProjectCard extends StatelessWidget {
  const FinishedProjectCard({
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
      ],
    );
  }
}
