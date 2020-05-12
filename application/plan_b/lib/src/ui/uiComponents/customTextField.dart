import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({this.focusNode, this.controller, this.inputType, @required this.labelText, this.hintText, this.maxLength});

  final String labelText;
  final String hintText;
  final TextInputType inputType;
  final FocusNode focusNode;
  final TextEditingController controller;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        maxLength: maxLength,
        focusNode: focusNode,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        keyboardType: inputType,
        style: Theme.of(context).textTheme.display2,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.display2,
          // TODO : style for text and inputdecoration
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.display2,
        ),
      ),
    );
  }
}