import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/utility/validator.dart';

class LoginScreen extends StatelessWidget with LogInValidator {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String username, password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        style: Theme.of(context).textTheme.display1,
                        validator: (value) {
                          return usernameValidator.isValid(value)
                              ? null
                              : notValidUsernameMessage;
                        },
                        decoration: InputDecoration(
                          hintText: "نام کاربری",
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        controller: _usernameController,
                        onSaved: (text) {
                          username = text;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.display1,
                        validator: (value) {
                          return passwordValidator.isValid(value)
                              ? null
                              : notValidPasswordMessage;
                        },
                        decoration: InputDecoration(
                          hintText: "رمز عبور",
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        obscureText: true,
                        controller: _passwordController,
                        onSaved: (text) {
                          password = text;
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RaisedButton(
                        child: Text(
                          "ورود",
                          style: Theme.of(context).textTheme.button,
                        ),
                        onPressed: _submit,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: Text("ایجاد حساب  ",
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: secondaryColor)),
                            onPressed: () {},
                          ),
                          Text(
                            "اکانت ندارید؟",
                            style: Theme.of(context).textTheme.display1,
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

  void _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      bloc.login(username, password);

    }
  }
}
