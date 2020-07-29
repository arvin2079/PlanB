import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({@required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 24),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
    );
  }
}
