import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/login_screen.dart';
import 'package:planb/src/utility/validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SignUpValidator{
  UserBloc bloc;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _emailController;
  TextEditingController _uniIdController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  User user;
  final GlobalKey<FormState> form_key = GlobalKey<FormState>();

  @override
  void initState() {
    bloc = UserBloc();
    user = User();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
              child: Image.asset("images/loginBackground.jpg")),
          SizedBox(
            height: 80,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 8,
                ),
                child: Form(
                  key: form_key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                          autofocus: true,
                          style: Theme.of(context).textTheme.display1,
                          validator: (value) {
                            return firstnameValidator.isValid(value) ? null : notValidFirstnameMessage;
                          },
                          decoration: InputDecoration(
                            hintText: "نام",
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          controller: _firstNameController,
                          onChanged: (text) {
                            user.firstName = text;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.display1,
                        validator: (value) {
                          return lastnameValidator.isValid(value) ? null : notValidLastnameMessage;
                        },
                        decoration: InputDecoration(
                            hintText: "نام خانوادگی",
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        controller: _lastNameController,
                        onChanged: (text) {
                          user.lastName = text;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.display1,
                        validator: (value) {
                          return uniIdValidator.isValid(value) ? null : notValidUniIdMessage;
                        },
                        decoration: InputDecoration(
                            hintText: "کد دانشجویی",
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        controller: _uniIdController,
                        onChanged: (text) {
                          user.lastName = text;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.display2,
                        validator: (value) {
                          return emailValidator.isValid(value) ? null : notValidEmailMessage;
                        },
                        decoration: InputDecoration(
                          hintText: "email",
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        controller: _emailController,
                        onChanged: (text) {
                          user.username = text;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.display2,
                        validator: (value) {
                          return usernameValidator.isValid(value) ? null : notValidUsernameMessage;
                        },
                        decoration: InputDecoration(
                          hintText: "username",
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        controller: _usernameController,
                        onChanged: (text) {
                          user.username = text;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.display1,
                        validator: (value) {
                          return passwordValidator.isValid(value) ? null : notValidPasswordMessage;
                        },
                        decoration: InputDecoration(
                          hintText: "رمز عبور",
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        obscureText: true,
                        controller: _passwordController,
                        onChanged: (text) {
                          user.password = text;
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: 15,
                      ),
//                      TextFormField(
//                        style: Theme.of(context).textTheme.display1,
//                        decoration: InputDecoration(
//                          hintText: "تکرار رمز عبور",
//                        ),
//                        textDirection: TextDirection.rtl,
//                        textAlign: TextAlign.right,
//                        obscureText: true,
//                        controller: _passwordController,
//                        onChanged: (text) {
//                          user.password = text;
//                        },
//                        textInputAction: TextInputAction.done,
//                      ),
//                      SizedBox(
//                        height: 40,
//                      ),
                      RaisedButton(
                        child: Text(
                          "ادامه و تکمیل اطلاعات",
                          // fixme : theme for in button texts
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        onPressed: () {
                          if(form_key.currentState.validate()) {
                            user.phoneNumber = "9382883937";
                            bloc.signUpNewUser(user);
                          }
//                          validateInputs(
//                              _usernameController.text, _passwordController.text);
//                          if (isInputsValid) {
//                            user.phoneNumber = "9382883937";
//                            bloc.signUpNewUser(user);
//                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: Text("وارد شوید  ",
                                style: Theme.of(context)
                                    .textTheme
                                    .display2
                                    .copyWith(color: secondaryColor)),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            },
                          ),
                          Text(
                            "اکانت ندارید؟",
                            style: Theme.of(context).textTheme.display2,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    bloc.dispose();
    super.dispose();
  }

//  validateInputs(String username, String password) {
//    passwordError = usernameError = null;
//    setState(() => isInputsValid = true);
//    if (password.length < 6)
//      setState(() {
//        passwordError = "رمز عبور نامعتبر میباشد";
//        isInputsValid = false;
//      });
//    if (username.length < 6) {
//      setState(() {
//        usernameError = "نام کاربری نامعتبر میباشد";
//        isInputsValid = false;
//      });
//    }
//  }
}
