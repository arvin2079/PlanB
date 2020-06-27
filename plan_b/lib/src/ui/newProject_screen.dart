import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/model/project_model.dart';
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

  List<String> _getSearchFieldSuggestion() {
    return <String>[
      'سرما',
      'حسن',
      'بیکار',
      'بیل',
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
      'سیب زمینی',
      'back-end',
      'yellow',
      'arvin',
      'container',
      'flutter',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ایجاد پروژه جدید',
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
                            requestProject.descriptions = value;
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
                            requestProject.name = value;
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
                              // TODO : fill requestProject.skillCodes when skill repository added
//                              if (_chipsData.isNotEmpty) {
//                                List skillCodes = List();
//                                for (String item in _chipsData) {
//                                  skillCodes.add(skillRepository.findSkillCodeByName(item));
//                                }
//                                requestProject.skillCodes = skillCodes;
//                              }
                              projectBloc.createNewProject(requestProject);
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
      ),
    );
  }

  Padding _buildSearchTextField(BuildContext context) {
    bool _isPersian = true;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: AutoCompleteTextField<String>(
        style: Theme.of(context).textTheme.headline1,
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
          return re.hasMatch(suggestion);
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
            _chipsData.removeWhere((data) {
              return item == data;
            });
          });
        },
      );
    }
  }
}
