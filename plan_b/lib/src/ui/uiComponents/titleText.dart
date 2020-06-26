import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TitleText extends StatelessWidget {
  const TitleText({@required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline3,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
    );
  }
}