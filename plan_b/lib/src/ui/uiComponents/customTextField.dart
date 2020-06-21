import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {this.errorText,
      this.helperText,
      this.focusNode,
      this.controller,
      this.inputType,
      @required this.labelText,
      this.hintText,
      this.maxLength});

  final String labelText;
  final String hintText;
  final String errorText;
  final String helperText;
  final TextInputType inputType;
  final FocusNode focusNode;
  final TextEditingController controller;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        focusNode: focusNode,
        style: Theme.of(context).textTheme.display1,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          helperText: helperText,
          errorText: errorText,
          labelText: labelText,
        ),
      ),
    );
  }
}
