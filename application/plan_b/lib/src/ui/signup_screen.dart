import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planb/src/ui/uiComponents/round_icon_avatar.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _searchInputController = TextEditingController();
  List<String> sexItems = <String>['پسر', 'دختر'];

  List<String> _uniItems = <String>[
    'امیرکبیر',
    'خوارزمی',
    'شریف',
    'مشهد',
    'خواجه نصیر',
  ];

  List<Chip> _chips = <Chip>[];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('تکمیل اطلاعات'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: LimitedBox(
          maxHeight: double.maxFinite,
          maxWidth: double.maxFinite,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Avatar(
                        icon: Icons.add,
                        iconSize: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('نام'),
                          Text('نام خوانوادگی'),
                        ],
                      ),
                    ],
                  ),
                  CustomtextField(labeltext: 'نام دانشگاه'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DropdownButton(
                        hint: Text('جنسیت'),
                        onChanged: (value) {
                          print(value);
                        },
                        items: sexItems.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButton(
                        hint: Text('دانشگاه'),
                        onChanged: (value) {
                          print(value);
                        },
                        items: _uniItems.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'اطلاعات تماس',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                  CustomtextField(
                    labeltext: 'موبایل',
                    inputType: TextInputType.phone,
                  ),
                  CustomtextField(
                    labeltext: 'ایمیل',
                    inputType: TextInputType.emailAddress,
                  ),
                  CustomtextField(
                    labeltext: 'وبسایت',
                    inputType: TextInputType.url,
                  ),
                  CustomtextField(labeltext: 'اینستاگرام'),
                  CustomtextField(labeltext: 'تلگرام'),
                  CustomtextField(labeltext: 'گیت'),
                  CustomtextField(labeltext: 'لینکدین'),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'اطلاعات تماس',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      textDirection: TextDirection.rtl,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        labelText: 'خلاصه ای از سوابغ خود بنویسید',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'مهارت های شما',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: AutoCompleteTextField<String>(
                      controller: _searchInputController,
                      itemSubmitted: (data) {
                        print('submited');
                      },
                      suggestions: _getSearchFieldSuggestion(
                          _searchInputController.text),
                      key: GlobalKey(),
                      itemFilter: (String suggestion, String query) {
                        // FIXME : implement itemFilter for search
                        return true;
                      },
                      itemSorter: (String a, String b) {
                        // FIXME : implement comparator for search
                        return 1;
                      },
                      itemBuilder: (BuildContext context, String suggestion) {
                        // FIXME : make style for list item Texts
                        return Text(suggestion);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Wrap(
                      children: _chips,
                      spacing: 10.0,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  RaisedButton(
                    child: Text('ادامه و تکمیل حساب'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<String> _getSearchFieldSuggestion(String data) {
    return <String>[
      'hello',
      'this is apple',
      'fuck',
      'yellow',
      'arvin',
      'container',
      'flutter',
    ];
  }
}

class CustomtextField extends StatelessWidget {
  const CustomtextField({this.inputType, @required this.labeltext});

  final String labeltext;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        textDirection: TextDirection.rtl,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: labeltext,
        ),
      ),
    );
  }
}
