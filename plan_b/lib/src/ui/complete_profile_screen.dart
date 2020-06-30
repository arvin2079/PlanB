import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/city_model.dart';
import 'package:planb/src/model/skill_model.dart';
import 'package:planb/src/model/university_model.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/ui/uiComponents/customTextField.dart';
import 'package:planb/src/ui/uiComponents/titleText.dart';
import 'package:planb/src/utility/imageCompressor.dart';
import 'package:planb/src/utility/languageDetector.dart';
import 'package:planb/src/utility/validator.dart';

class CompleteProfileScreen extends StatefulWidget {
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>
    with ImageCompressor, LanguageDetector, CompleteProfileValidator {
  TextEditingController _searchInputController = TextEditingController();

  String _genderTitle = 'جنسیت';
  String _universityTitle = 'دانشگاه';
  String _cityTitle = 'شهر';

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  ImageProvider _image;

  List<String> _chipsData = <String>[];

  List<String> genderItems = <String>['مرد', 'زن'];

  CityRepository cityRepository;
  UniversityRepository universityRepository;
  SkillRepository skillRepository;

  User requestUser;

  List<String> _getSearchFieldSuggestion() {
    return skillRepository.getNames();
  }

  @override
  void initState() {
    requestUser = User();
    userBloc.getCompleteProfileFields();
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
            !Navigator.of(context).canPop()
                ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                  )
                : Container()
          ],
        ),
        body: Builder(
          builder: (context) => LimitedBox(
            maxHeight: double.maxFinite,
            maxWidth: double.maxFinite,
            child: Form(
              key: _formkey,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: StreamBuilder<User>(
                        stream: userBloc.userInfoStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return _buildScreenWidget(snapshot.data);
                          }
                          return LinearProgressIndicator(
                            backgroundColor: Colors.transparent,
                          );
                        }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreenWidget(User user) {
    requestUser = user;
    print(user);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                backgroundImage: _image,
                child: _image == null
                    ? Icon(Icons.photo_camera, color: Colors.black45, size: 30)
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
                  user.firstName == null ? 'empty' : user.firstName,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 10),
                Text(
                  user.lastName == null ? 'empty' : user.lastName,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ],
        ),
        //fixme: fix initial values for drop boxes
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            DropdownButton(
              hint: Text(
                user.gender == null
                    ? _genderTitle
                    : (user.gender ? 'مرد' : 'زن'),
                style: Theme.of(context).textTheme.headline4,
              ),
              onChanged: (value) {
                setState(() {
                  requestUser.gender = value == 'مرد';
                  _genderTitle = value;
                });
              },
              items: genderItems.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }).toList(),
            ),
            DropdownButton(
              hint: Text(
                user.cityCode == null
                    ? _cityTitle
                    : cityRepository.findCityTitleByCode(user.cityCode),
                style: Theme.of(context).textTheme.headline4,
              ),
              onChanged: (value) {
                setState(() {
                  requestUser.cityCode =
                      cityRepository.findCityCodeByTitle(value);
                  _cityTitle = value;
                });
              },
              items: cityRepository.getTitles().map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }).toList(),
            ),
            DropdownButton(
              hint: Text(
                user.universityCode == null
                    ? _universityTitle
                    : universityRepository
                        .findUniversityNameByCode(user.universityCode),
                style: Theme.of(context).textTheme.headline4,
              ),
              onChanged: (value) {
                setState(() {
                  requestUser.universityCode =
                      universityRepository.findUniversityCodeByName(value);
                  _universityTitle = value;
                });
              },
              items: universityRepository.getNames().map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        SizedBox(height: 30),
        TitleText(text: 'اطلاعات تماس'),
        CustomTextField(
          controller: TextEditingController(text: user.phoneNumber.toString()),
          initialValue: user.phoneNumber.toString(),
          labelText: 'موبایل',
          inputType: TextInputType.phone,
          maxLength: 11,
          validator: (value) {
            return phoneNumberValidator.isValid(value)
                ? null
                : notValidPhoneNumberErrorMassage;
          },
          onSaved: (text) {
            requestUser.phoneNumber = text;
          },
        ),
        CustomTextField(
          controller: TextEditingController(text: user.email),
          initialValue: user.email,
          labelText: 'ایمیل',
          inputType: TextInputType.emailAddress,
          hintText: "example@gmail.com",
          validator: (value) {
            return emailValidator.isValid(value) ? null : notValidEmailMessage;
          },
          onSaved: (text) {
            requestUser.email = text;
          },
        ),
        CustomTextField(
          controller:
              TextEditingController(text: user.studentCode.toString()),
          labelText: 'شماره دانشجویی',
          inputType: TextInputType.number,
          onSaved: (text) {
            requestUser.studentCode = text;
          },
        ),

        CustomTextField(
//          TODO : controller: TextEditingController(),
          labelText: 'اینستاگرام',
          hintText: "yourID",
          validator: (value) {
            return socialMediaIdValidator.isValid(value)
                ? null
                : notValidSocialMediaErrorMassage;
          },
          onSaved: (text) {},
        ),
        CustomTextField(
//          TODO : controller: TextEditingController(),
          labelText: 'تلگرام',
          hintText: "yourID",
          validator: (value) {
            return socialMediaIdValidator.isValid(value)
                ? null
                : notValidSocialMediaErrorMassage;
          },
          onSaved: (text) {},
        ),
        CustomTextField(
//          TODO : controller: TextEditingController(),
          labelText: 'گیت',
          hintText: "yourID",
          validator: (value) {
            return socialMediaIdValidator.isValid(value)
                ? null
                : notValidSocialMediaErrorMassage;
          },
          onSaved: (text) {},
        ),
        CustomTextField(
//          TODO : controller: TextEditingController(),
          labelText: 'لینکدین',
          hintText: "yourID",
          validator: (value) {
            return socialMediaIdValidator.isValid(value)
                ? null
                : notValidSocialMediaErrorMassage;
          },
          onSaved: (text) {},
        ),
        SizedBox(height: 30),

        TextArea(
          controller: TextEditingController(text: user.descriptions),
          labelText: 'خلاصه‌ای از سوابق خود بنویسید',
          validator: (value) {
            return descriptionValidator.isValid(value)
                ? null
                : notValidDescriptionErrorMassage;
          },
          onSaved: (text) {
            requestUser.descriptions = text;
          },
        ),
        SizedBox(height: 30),
        TitleText(text: 'مهارت‌های شما'),
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
            'ذخیره اطلاعات',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () {
            _formkey.currentState.save();
            if (_formkey.currentState.validate()) {
              if (_chipsData.isNotEmpty) {
                List skillCodes = List();
                for (String item in _chipsData) {
                  skillCodes.add(skillRepository.findSkillCodeByName(item));
                }
                requestUser.skillCodes = skillCodes;
              }
              userBloc.completeProfile(requestUser);
              _showAlert(context);
            }
          },
        ),
      ],
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => StreamBuilder(
            stream: userBloc.errorsStream,
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
                          ? "خطا در بروزرسانی اطلاعات!"
                          : "اطلاعات با موفقیت بروزرسانی شد",
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
                        child: Text(_hasError ? "بیخیال" : "ادامه"),
                      ),
                    ],
                  )
                ],
              );
              return widget;
            }));
//    Navigator.of(context).pop();
//    Navigator.of(context).pop();
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
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child:
                Text(suggestion, style: Theme.of(context).textTheme.headline2),
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
            title: Text(
              'انتخاب نمایید',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.right,
            ),
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
                  Navigator.of(context).pushReplacementNamed('/home');
                  return _getImage(ImageSource.gallery);
                },
              ),
            ],
          );
        });
  }

  void initializeItems() async {
    userBloc.universitiesStream.first.then((value) {
      if (value != null) {
        List<University> _universityObjects = [];
        for (int i = 0; i < value.length; i++) {
          University university = University.fromJson(value[i]);
          _universityObjects.add(university);
        }
        universityRepository =
            UniversityRepository(universities: _universityObjects);
      }
    });

    userBloc.skillsStream.first.then((value) {
      if (value != null) {
        List<Skill> _skillObjects = [];
        for (int i = 0; i < value.length; i++) {
          Skill skill = Skill.fromJson(value[i]);
          _skillObjects.add(skill);
        }
        skillRepository = SkillRepository(skills: _skillObjects);
        print(skillRepository.getNames());
      }
    });

    userBloc.citiesStream.first.then((value) {
      if (value != null) {
        List<City> _cityObjects = [];
        for (int i = 0; i < value.length; i++) {
          City city = City.fromJson(value[i]);
          _cityObjects.add(city);
        }
        cityRepository = CityRepository(cities: _cityObjects);
      }
    });
  }
}

// fixme : search field item font ROBOTO download
