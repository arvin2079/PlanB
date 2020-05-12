import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:planb/src/ui/constants/constants.dart';

import 'uiComponents/customTextField.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
              child: Image.asset("images/loginBackground.jpg")),
          SizedBox(height:80,),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8,),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CustomTextField(
                      hintText: 'نام کاربری',
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      hintText: 'رمز عبور',
                      inputType: TextInputType.text,
                    ),
                    SizedBox(height: 20,),
                    RaisedButton(
                      child: Text("ورود", style: Theme.of(context).textTheme.button,),
                      onPressed: (){},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        FlatButton(
                          child: Text("ایجاد حساب  ", style: Theme.of(context).textTheme.display2.copyWith(color: secondaryColor)),
                          onPressed: (){},
                        ),
                        Text("اکانت ندارید؟", style: Theme.of(context).textTheme.display2,),
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
}
