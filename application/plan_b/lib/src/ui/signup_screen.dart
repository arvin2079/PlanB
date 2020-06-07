import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/ui/login_screen.dart';


class SignUpScreen extends StatelessWidget {
  UserBloc bloc = UserBloc();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  User user = User();

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
                        labelStyle: Theme.of(context).textTheme.button,
                      ),
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
                      height: 40,
                    ),
                    RaisedButton(
                      child: Text(
                        "ادامه و تکمیل اطلاعات",
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () {
                        user.phoneNumber = "9382883937";
                        bloc.signUpNewUser(user);
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
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
  void dispose(){
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    bloc.dispose();
  }
}
