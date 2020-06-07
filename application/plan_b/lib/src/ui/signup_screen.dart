import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserBloc bloc;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  String passwordError;
  String usernameError;
  bool isInputsValid;
  User user;

  @override
  void initState() {
    bloc = UserBloc();
    user = User();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    isInputsValid = true;
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextField(
                        autofocus: true,
                        style: Theme.of(context).textTheme.display2,
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
                        onSubmitted: (_) => FocusScope.of(context).nextFocus()),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      style: Theme.of(context).textTheme.display2,
                      decoration: InputDecoration(
                          hintText: "نام خانوادگی",
                          labelStyle: Theme.of(context).textTheme.display2),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      controller: _lastNameController,
                      onChanged: (text) {
                        user.lastName = text;
                      },
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      style: Theme.of(context).textTheme.display2,
                      decoration: InputDecoration(
                        hintText: "نام کاربری",
                        errorText: usernameError,
                      ),
                      maxLength: 10,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      controller: _usernameController,
                      onChanged: (text) {
                        user.username = text;
                      },
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      style: Theme.of(context).textTheme.display2,
                      decoration: InputDecoration(
                          hintText: "رمز عبور", errorText: passwordError),
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
                      height: 40,
                    ),
                    RaisedButton(
                      child: Text(
                        "ادامه و تکمیل اطلاعات",
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () {
                        validateInputs(
                            _usernameController.text, _passwordController.text);
                        if (isInputsValid) {
                          user.phoneNumber = "9382883937";
                          bloc.signUpNewUser(user);
                        }
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

  validateInputs(String username, String password) {
    passwordError = usernameError = null;
    setState(() => isInputsValid = true);
    if (password.length < 6)
      setState(() {
        passwordError = "رمز عبور نامعتبر میباشد";
        isInputsValid = false;
      });
    if (username.length < 6) {
      setState(() {
        usernameError = "نام کاربری نامعتبر میباشد";
        isInputsValid = false;
      });
    }
  }
}
