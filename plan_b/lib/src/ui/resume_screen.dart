import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/model/skill_model.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/uiComponents/drawer.dart';
import 'package:planb/src/ui/uiComponents/offline_error.dart';
import 'package:planb/src/ui/uiComponents/titleText.dart';

class ResumeScreen extends StatefulWidget {
  final int id;
  SkillRepository skillRepository;

  ResumeScreen({this.id, this.skillRepository});

  @override
  _ResumeScreenState createState() => _ResumeScreenState(id: id);
}

class _ResumeScreenState extends State<ResumeScreen> {
  _ResumeScreenState({this.id});

  int id;
  User user;

  @override
  void initState() {
    userBloc.getResume(id);
    super.initState();
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
      body: StreamBuilder<User>(
        stream: userBloc.resumeStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data;
            return _buildScreenWidget();
          }
          if (snapshot.hasError) {
            return OfflineError(
              function: () {
                userBloc.getResume(id);
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildScreenWidget() {
    return RefreshIndicator(
      displacement: 10,
      onRefresh: _refresh,
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: ListView(
              children: _buildScreenElements(user),
            ),
          )),
    );
  }

  _buildSkillChips(List skillCodes) {
    List<Widget> result = [];
    for (int i in skillCodes) {
      result.add(
          widget.skillRepository != null ? Chip(
        label: Text(widget.skillRepository?.findSkillNameByCode(i)),
      ) : LinearProgressIndicator());
      result.add(SizedBox(
        width: 5,
      ));
    }
    return result;
  }

  List<Widget> _buildScreenElements(User user) {
    List<Widget> _result = <Widget>[
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
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
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
                        user.description ?? "",
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
            decoration:
                ShapeDecoration(shape: CircleBorder(), color: Colors.white),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: DecoratedBox(
                decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: user.avatar == null
                            ? AssetImage('images/noImage.png')
                            : NetworkImage(user.avatar))),
              ),
            ),
          )
        ],
      ),
      Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TitleText(text: 'مهارت ها'),
              Wrap(children: _buildSkillChips(user.skillCodes)),
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
    ];
    for (Project p in user.projects) {
      bool isCreated = user.id == p.creator.id;
      Widget c = Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  p.name,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 24,
                      color: isCreated ? primaryColor : secondaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Icon(
                    isCreated ? Icons.add_comment : Icons.person_add,
                    color: isCreated ? primaryColor : secondaryColor,
                    size: 28,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(user.id == p.creator.id ? "سازنده" : "مشارکت",
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: isCreated ? primaryColor : secondaryColor)),
                Divider(color: isCreated ? primaryColor : secondaryColor),
                Text(p.descriptions,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: 18, fontWeight: FontWeight.normal)),
              ],
            ),
          ),
        ),
      );
      _result.add(c);
    }
    return _result;
  }

  Future<void> _refresh() async {
    await userBloc.getResume(id);

    setState(() {

    });

    return null;
  }
}
