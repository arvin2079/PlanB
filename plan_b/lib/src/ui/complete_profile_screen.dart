import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/ui/uiComponents/customTextField.dart';
import 'package:planb/src/ui/uiComponents/round_icon_avatar.dart';
import 'package:planb/src/ui/uiComponents/titleText.dart';
import 'package:planb/src/utility/imageCompressor.dart';
import 'package:planb/src/utility/languageDetector.dart';

class CompleteProfileScreen extends StatefulWidget {
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>
    with ImageCompressor, LanguageDetector {
  TextEditingController _searchInputController = TextEditingController();
  String _genderTitle = 'جنسیت';
  String _universityTitle = 'دانشگاه';
  final GlobalKey _fromKey = GlobalKey<FormState>();
  User user = User(firstName: "mamad", lastName: 'mamad');

  ImageProvider _image;

  List<String> genderItems = <String>['مرد', 'زن'];

  List<String> _chipsData = <String>[];

  List<String> _universityItems = <String>[];
  List<String> _skillItems = <String>[];
  List<String> _cityItems = <String>[];

  List<String> _getSearchFieldSuggestion(String data) {
    return <String>[
      'hello',
      'this is apple',
      'android',
      'ios',
      'art',
      'python',
      'front-end',
      'fuck',
      'film',
      'fish',
      'foster',
      'felamingo',
      'back-end',
      'yellow',
      'arvin',
      'container',
      'flutter',
    ];
  }

  @override
  void initState() {
    bloc.getCompleteProfileFields();
    initializeItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تکمیل اطلاعات',
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Builder(
          builder: (context) => LimitedBox(
            maxHeight: double.maxFinite,
            maxWidth: double.maxFinite,
            child: Form(
              key: _fromKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              backgroundImage: _image,
                              child: _image == null
                                  ? Icon(Icons.photo_camera,
                                      color: Colors.black45, size: 30)
                                  : null,
                              radius: 35,
                            ),
                            onTap: () => _pickImage(),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // fixme : style for these texts
                              //fixme: user must enter his name, its a static text!
                              Text(
                                'نام',
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                              SizedBox(height: 10),
                              Text(
                                user.firstName,
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      //fixme: university has a dropBox for choose and its useless
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          DropdownButton(
                            hint: Text(
                              _genderTitle,
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                _genderTitle = value;
                              });
                            },
                            items: genderItems.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              );
                            }).toList(),
                          ),
                          DropdownButton(
                            hint: Text(
                              _universityTitle,
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                _universityTitle = value;
                              });
                            },
                            items: _universityItems.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      TitleText(text: 'اطلاعات تماس'),
                      CustomTextField(
                        labelText: 'موبایل',
                        inputType: TextInputType.phone,
                        maxLength: 11,
                        hintText: "09123456789",
                      ),
                      CustomTextField(
                        labelText: 'ایمیل',
                        inputType: TextInputType.emailAddress,
                        hintText: "example@gmail.com",
                      ),
                      CustomTextField(
                        labelText: 'وبسایت',
                        inputType: TextInputType.url,
                        hintText: "www.example.com",
                      ),
                      CustomTextField(
                        labelText: 'اینستاگرام',
                        hintText: "yourID",
                      ),
                      CustomTextField(
                        labelText: 'تلگرام',
                        hintText: "yourID",
                      ),
                      CustomTextField(
                        labelText: 'گیت',
                        hintText: "yourID",
                      ),
                      CustomTextField(
                        labelText: 'لینکدین',
                        hintText: "yourID",
                      ),
                      SizedBox(height: 30),
                      //todo: convert textfield to textarea if we need
//                      TextArea(labelText: 'خلاصه ای از سوابغ خود بنویسید'),
                      CustomTextField(
                        labelText: 'سوابق خود را بنویسید',
                      ),
                      SizedBox(height: 30),
                      TitleText(text: 'مهارت های شما'),
                      _buildSearchTextField(context),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Wrap(
                          children: _chipWidgets.toList(),
                          spacing: 10.0,
                        ),
                      ),
                      SizedBox(height: 100),
                      RaisedButton(
                        child: Text(
                          'ادامه و تکمیل حساب',
                        ),
                        onPressed: () {
                          bloc.getCompleteProfileFields();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildSearchTextField(BuildContext context) {
    bool _isPersian = true;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: AutoCompleteTextField<String>(
        style: _isPersian
            ? Theme.of(context).textTheme.display1
            : Theme.of(context).textTheme.display2,
        controller: _searchInputController,
        clearOnSubmit: true,
        textSubmitted: (value) {},
        itemSubmitted: (data) {
          setState(() {
            if (!_chipsData.contains(data))
              _chipsData.add(data);
            else {
              // fixme : this part throw an error when i want to show alert snackbar (fixed)
              // solution : This exception happens because you are using the context of the widget that instantiated Scaffold. Not the context of a child of Scaffold.
              // for this we add builder to the Scaffold body so builder parent is scaffold and can be userd via ther context.
              // solution : using globaleKey for the scaffold :
              // _scaffoldKey.currentState.showSnackBar(snackbar);

              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  'این مهارت قبلا اضافه شده',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'yekan',
                  ),
                ),
              ));
            }
          });
        },
        suggestions: _getSearchFieldSuggestion(_searchInputController.text),
        key: GlobalKey(),
        itemFilter: (String suggestion, String query) {
          return suggestion.contains(RegExp(r'\b' + '${query.toLowerCase()}'));
        },
        itemSorter: (String a, String b) {
          if (a.length < b.length)
            return -1;
          else
            return 1;
        },
        itemBuilder: (BuildContext context, String suggestion) {
          // FIXME : make style for list item Texts
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              suggestion,
              style: hasEnglishChar(suggestion)
                  ? Theme.of(context).textTheme.display4
                  : Theme.of(context).textTheme.display3,
            ),
          );
        },
      ),
    );
  }

  Iterable<Widget> get _chipWidgets sync* {
    for (final String item in _chipsData) {
      yield Chip(
        label: Text(item),
        onDeleted: () {
          setState(() {
            _chipsData.removeWhere((data) {
              return item == data;
            });
          });
        },
      );
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    File file = File(pickedFile.path);
    File finalFile = await compressAndGetFile(file);
    var bytes = await finalFile.readAsBytes();
    _image = MemoryImage(bytes);
    setState(() {});
  }

  void _pickImage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('انتخاب نمایید'),
            actions: <Widget>[
              RaisedButton(
                child: Text('دوربین'),
                onPressed: () {
                  Navigator.of(context).pop();
                  return _getImage(ImageSource.camera);
                },
              ),
              RaisedButton(
                child: Text('گالری'),
                onPressed: () {
                  Navigator.of(context).pop();
                  return _getImage(ImageSource.gallery);
                },
              ),
            ],
          );
        });
  }

  void initializeItems() async {
    bloc.universitiesStream.first.then((value) {
      if (value != null) {
        List<String> names = List<String>();
        _universityItems = names;
      }
    });

    bloc.skillsStream.first.then((value) {

      if (value != null) {
        List<String> names = List<String>();
        _skillItems = names;
      }
    });

    bloc.citiesStream.first.then((value) {
      if (value != null) {
        List<String> names = List<String>();
        _cityItems = names;
      }
    });

    bloc.userInfoStream.first.then((value){

      if(value != null){
        user = value;
      }
    });
  }
}

// fixme : search field item font ROBOTO download
// todo : create validator for each textfield
