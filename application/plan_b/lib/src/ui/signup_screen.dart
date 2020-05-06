import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('تکمیل اطلاعات'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: LimitedBox(
          maxHeight: double.maxFinite,
          maxWidth: double.maxFinite,
          child: Center(
            child: Container(
              height: 50,
              width: 50,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
