import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/model/skill_model.dart';
import 'package:planb/src/ui/uiComponents/customTextField.dart';
import 'package:planb/src/ui/uiComponents/titleText.dart';
import 'package:planb/src/utility/imageCompressor.dart';
import 'package:planb/src/utility/languageDetector.dart';
import 'package:planb/src/utility/validator.dart';

import 'constants/constants.dart';

class NewProjectScreen extends StatefulWidget {
  @override
  _NewProjectScreenState createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<NewProjectScreen>
    with ImageCompressor, LanguageDetector, NewProjectValidator {
  final TextEditingController _searchInputController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Project requestProject = Project();

  List<String> _chipsData = <String>[];

  SkillRepository skillRepository = SkillRepository();

  List<String> _getSearchFieldSuggestion() {
    return skillRepository.getNames();
  }

  @override
  void initState() {
    userBloc.getCompleteProfileFields();
    initializeItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userBloc.skillsStream,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return _buildScreenWidget();
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  _buildScreenWidget(){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ایجاد پروژه جدید',
          ),
        ),
        body: LimitedBox(
            maxHeight: double.maxFinite,
            maxWidth: double.maxFinite,
            child: Form(
              key: _formkey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ScrollConfiguration(
                  behavior: NoGlowScrollBehavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 10),
                        TextFormField(
                          autofocus: true,
                          style: Theme.of(context).textTheme.headline1,
                          decoration: InputDecoration(
                            labelText: "نام پروژه",
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            return projectNameValidator.isValid(value) ? null : notValidProjectNameErrorMassage;
                          },
                          onSaved: (value) {
                            requestProject.name = value;
                          },
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                        ),
                        SizedBox(height: 15),
                        _buildSearchTextField(context),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Wrap(
                            children: _chipWidgets.toList(),
                            spacing: 10.0,
                          ),
                        ),
                        SizedBox(height: 15),
                        TitleText(text: 'شرح پروژه'),
                        TextArea(
                          validator: (value) {
                            return descriptionValidator.isValid(value) ? null : notValidDescriptionErrorMassage;
                          },
                          onSaved: (value) {
                            requestProject.descriptions = value;
                          },
                        ),
                        SizedBox(height: 15),
                        RaisedButton(
                          child: Text(
                            'ایجاد پروژه',
                            style: Theme.of(context).textTheme.button,
                          ),
                          onPressed: () {
                            if(_formkey.currentState.validate()) {
                              _formkey.currentState.save();
                              if (_chipsData.isNotEmpty) {
                                List skillCodes = List();
                                for (String item in _chipsData) {
                                  skillCodes.add(skillRepository.findSkillCodeByName(item));
                                }
                                requestProject.skillCodes = skillCodes;
                              }
                              projectBloc.createNewProject(requestProject);
                              _showAlert(context);
                            }
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

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => StreamBuilder(
            stream: projectBloc.errorsStream,
            builder: (context, snapshot) {
              bool _hasError = snapshot.hasData;
              Widget widget = AlertDialog(
                title: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      "تکمیل اطلاعات",
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.right,
                    )),
                content: Row(
                  children: <Widget>[
                    !_hasError
                        ? Icon(
                      Icons.done_outline,
                      color: Colors.green,
                    )
                        : Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                          _hasError
                              ? "خطا در ثبت پروژه!"
                              : "پروژه جدید شما ثبت شد",
                          style: Theme.of(context).textTheme.headline1,
                        ))
                  ],
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text(_hasError ? "بیخیال" : "باشه"),
                      ),
                    ],
                  )
                ],
              );
              return widget;
            }));
  }

  Widget _buildSearchTextField(BuildContext context) {
    bool _isPersian = true;

    return Builder(
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: AutoCompleteTextField<String>(
          style: Theme.of(context).textTheme.headline1,
          controller: _searchInputController,
          clearOnSubmit: true,
          textSubmitted: (value) {},
          itemSubmitted: (data) {
            setState(() {
              _formkey.currentState.save();
              if (!_chipsData.contains(data))
                {
                  _chipsData.add(data);
                }
              else {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'این مهارت قبلا اضافه شده',
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(milliseconds: 500),
                ));
              }
            });
          },
          suggestions: _getSearchFieldSuggestion(),
          key: GlobalKey(),
          decoration: InputDecoration(labelText: 'مهارت های این پروژه'),
          itemFilter: (String suggestion, String query) {
            RegExp re = RegExp(r'^' + query.toLowerCase() + r'.*');
            return re.hasMatch(suggestion.toLowerCase());
          },
          itemSorter: (String a, String b) {
            if (a.length < b.length)
              return -1;
            else
              return 1;
          },
          itemBuilder: (BuildContext context, String suggestion) {
            // FIXME : make style for list item Texts
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                suggestion,
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          },
        ),
      ),
    );
  }

  Iterable<Widget> get _chipWidgets sync* {
    for (final String item in _chipsData) {
      yield Chip(
        label: Text(
          item,
          style: Theme.of(context).textTheme.caption,
        ),
        onDeleted: () {
          setState(() {
            _formkey.currentState.save();
            _chipsData.removeWhere((data) {
              return item == data;
            });
          });
        },
      );
    }
  }

  void initializeItems() async {

    userBloc.skillsStream.first.then((value) {
      if (value != null) {
        List<Skill> _skillObjects = [];
        for (int i = 0; i < value.length; i++) {
          Skill skill = Skill.fromJson(value[i]);
          _skillObjects.add(skill);
        }
        skillRepository = SkillRepository(skills: _skillObjects);
      }
    });
  }
}
