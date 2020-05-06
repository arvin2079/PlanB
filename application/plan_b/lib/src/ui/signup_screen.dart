import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planb/src/ui/uiComponents/autoCompleteTextView.dart';
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
    'خواجه نصیر'
  ];

  List<Chip> _chips = <Chip>[
    Chip(
      label: Text('sdf'),
      onDeleted: () {},
    )
  ];

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
                  customtextField(labeltext: 'نام دانشگاه'),
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
                  customtextField(
                    labeltext: 'موبایل',
                    inputType: TextInputType.phone,
                  ),
                  customtextField(
                    labeltext: 'ایمیل',
                    inputType: TextInputType.emailAddress,
                  ),
                  customtextField(
                    labeltext: 'وبسایت',
                    inputType: TextInputType.url,
                  ),
                  customtextField(labeltext: 'اینستاگرام'),
                  customtextField(labeltext: 'تلگرام'),
                  customtextField(labeltext: 'گیت'),
                  customtextField(labeltext: 'لینکدین'),
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
                    child: AutoCompleteTextView(
                      controller: _searchInputController,
                      getSuggestionsMethod: _getSuggestionMethod,
                    ),
                  ),
//                  Padding(
//                    padding: EdgeInsets.symmetric(vertical: 10),
//                    child: TextField(
//                     onEditingComplete: () {
//                       // todo : add chips to the _chips by the search
//                     },
//                      textDirection: TextDirection.rtl,
//                      controller: _searchInputController,
//                      decoration: InputDecoration(
//                        hintText: 'جستجوی مهارت ها',
//                        icon: Icon(Icons.search),
//                      ),
//                    ),
//                  ),
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
                    onPressed: (){},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<String> _getSuggestionMethod(String data) {
    return [
      'hello1',
      'hello2',
      'hello3',
      'hello4',
      'hello5',
      'hello6',
    ];
  }
}

class customtextField extends StatelessWidget {
  const customtextField({this.inputType, @required this.labeltext});

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
