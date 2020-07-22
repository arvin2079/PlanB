import 'package:flutter/material.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';
import 'package:planb/src/ui/uiComponents/request_user_button.dart';
import 'package:planb/src/ui/uiComponents/simple_user_button.dart';

class DoneProjectsTabCreated extends StatefulWidget {
  // fixme : pass the list of items from home or each tab get its own items
//  const DoneProjectsTab({this._doneProjectsTabList});
//  final List<ProjectItem> _doneProjectsTabList;

  @override
  _DoneProjectsTabCreatedState createState() => _DoneProjectsTabCreatedState();
}

class _DoneProjectsTabCreatedState extends State<DoneProjectsTabCreated> {
  List<ProjectItem> _doneProjectsTabList = <ProjectItem>[
    // example
    ProjectItem(
      title: 'پروژه اول شما',
      caption: 'اینجا توضیح کوتاهی درمورد اولین پروژه شما نوشته خواهد شد',
      requests: <UserPr>[
        UserPr(
          'آتنا',
          'گنجی',
        ),
        UserPr(
          'آتنا',
          'گنجی',
        ),
        UserPr(
          'آتنا',
          'گنجی',
        ),
      ],
      creator: UserPr(
        'آتنا',
        'گنجی',
      ),
      team: <UserPr>[
        UserPr(
          'آروین',
          'صادقی',
        ),
        UserPr(
          'عرفان',
          'صبحایی',
        ),
        UserPr(
          'نیما',
          'پریفرد',
        ),
        UserPr(
          'آروین',
          'صادقی',
        ),
        UserPr(
          'عرفان',
          'صبحایی',
        ),
        UserPr(
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
      creator: UserPr(
        'آتنا',
        'گنجی',
      ),
      team: <UserPr>[
        UserPr(
          'آروین',
          'صادقی',
        ),
        UserPr(
          'عرفان',
          'صبحایی',
        ),
        UserPr(
          'نیما',
          'پریفرد',
        ),
        UserPr(
          'آروین',
          'صادقی',
        ),
        UserPr(
          'عرفان',
          'صبحایی',
        ),
        UserPr(
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
      caption:
          'اینجا توضیح کوتاهی درمورد اولین پروژه شما نوشته خواهد شد.اینجا توضیح کوتاهی درمورد اولین پروژه شما نوشته خواهد شد.اینجا توضیح کوتاهی درمورد اولین پروژه شما نوشته خواهد شد.اینجا توضیح کوتاهی درمورد اولین پروژه شما نوشته خواهد شد',
      creator: UserPr(
        'آتنا',
        'گنجی',
      ),
      team: <UserPr>[
        UserPr(
          'آروین',
          'صادقی',
        ),
        UserPr(
          'عرفان',
          'صبحایی',
        ),
        UserPr(
          'نیما',
          'پریفرد',
        ),
        UserPr(
          'آروین',
          'صادقی',
        ),
        UserPr(
          'عرفان',
          'صبحایی',
        ),
        UserPr(
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
  ];

  @override
  void initState() {
    projectBloc.getProjects();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    projectBloc.getProjects();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: projectBloc.projectStream,
      builder: (context, snapshot) {

        if(/*snapshot.hasData*/true){
          return SingleChildScrollView(
            child: Column(
              children: _getProjectCards.toList(),
            ),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      }
    );
  }

  Iterable<Widget> get _getProjectCards sync* {
    for (ProjectItem item in _doneProjectsTabList) {
      yield CreatorViewProjectCard(item: item, context: context);
    }
  }
}

class CreatorViewProjectCard extends StatelessWidget {
  const CreatorViewProjectCard({
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
              onPressed: (){},
            );
          },
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'درخواست های همکاری',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        item.requests != null && item.requests.isNotEmpty ? ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: item.requests.length,
          itemBuilder: (context, index) {
            return RequestUserButton(
              leftColor: green2Color,
              rightColor: green1Color,
              name: item.requests[index].name,
              lastname: item.requests[index].lastname,
              trailingIcon: Icon(Icons.group, color: Colors.white, size: 150),
              onReject: (){},
              onAccept: (){},
            );
          },
        ) : Text('هیچ درخواستی ثبت نشده  :/', style: Theme.of(context).textTheme.headline1.copyWith(
          color: Colors.grey[500]
        ),),
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
          child: Text('اتمام پروژه', style: Theme.of(context).textTheme.button),
          onPressed: (){},
        )
      ],
    );
  }
}
