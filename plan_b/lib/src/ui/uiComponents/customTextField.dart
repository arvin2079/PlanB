import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/utility/languageDetector.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {this.errorText,
      this.focusNode,
      this.controller,
      this.inputType,
      @required this.labelText,
      this.hintText,
      this.maxLength});

  final String labelText;
  final String hintText;
  final String errorText;
  final TextInputType inputType;
  final FocusNode focusNode;
  final TextEditingController controller;
  final int maxLength;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with LanguageDetector {
  bool _isPersian = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        maxLength: widget.maxLength,
        focusNode: widget.focusNode,
        style: _isPersian
            ? Theme.of(context).textTheme.display1
            : Theme.of(context).textTheme.display2,
        onChanged: (value) {
          print(value);
          setState(() {
            if (hasEnglishChar(value) || value.isEmpty) {
              _isPersian = false;
            } else {
              _isPersian = true;
            }
          });
        },
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.display1,
          hintText: widget.hintText,
          errorText: widget.errorText,
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
