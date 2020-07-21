import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/ui/constants/constants.dart';
import 'package:planb/src/utility/validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LogInValidator {
  TextEditingController _usernameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  String username, password;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: StreamBuilder(
            stream: userBloc.authStatusStream,
            builder: (context, snapshot) {
              if (snapshot.data == AuthStatus.loading) {
                return CircularProgressIndicator();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(40)),
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
                                style: Theme.of(context).textTheme.headline1,
                                validator: (value) {
                                  print(usernameValidator.isValid(value));
                                  return usernameValidator.isValid(value)
                                      ? null
                                      : notValidUsernameMessage;
                                },
                                decoration: InputDecoration(
                                  hintText: "نام کاربری",
                                ),
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
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
                                style: Theme.of(context).textTheme.headline1,
                                validator: (value) {
                                  return passwordValidator.isValid(value)
                                      ? null
                                      : notValidPasswordMessage;
                                },
                                decoration: InputDecoration(
                                  hintText: "رمز عبور",
                                ),
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                obscureText: true,
                                controller: _passwordController,
                                onSaved: (text) {
                                  password = text;
                                },
                                textInputAction: TextInputAction.done,
                              ),
                              SizedBox(
                                height: 35,
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
                                    child: Text("ایجاد کن",
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(color: secondaryColor)),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/signup');
                                    },
                                  ),
                                  Text(
                                    "اکانت نداری؟",
                                    style: Theme.of(context).textTheme.caption,
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
              );
            }),
      ),
    );
  }

  void _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      userBloc.login(username, password);
      userBloc.authStatusStream.first.then((value) {
        if (value == AuthStatus.signedIn) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (value == AuthStatus.signedOut) {
          SnackBar snackBar = SnackBar(
            //fixme snack bar must show based on response json
            /*content: StreamBuilder(
              stream: bloc.errorsStream,
              builder: (context, AsyncSnapshot<String> snapshot){

                for(String error in snapshot.data){}
                return Text("");
              },
            ),*/
            content: Text(
              "خطا در ورود! دوباره امتخان کن...",
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: Colors.red,
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
        }
      });
    }
  }
}
