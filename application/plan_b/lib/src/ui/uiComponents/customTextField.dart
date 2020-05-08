import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomtextField extends StatelessWidget {
  const CustomtextField({this.focusNode, this.controller, this.inputType, @required this.labeltext});

  final String labeltext;
  final TextInputType inputType;
  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textDirection: TextDirection.rtl,
        keyboardType: inputType,
        decoration: InputDecoration(
          // TODO : style for text and inputdecoration
          labelText: labeltext,
        ),
      ),
    );
  }
}