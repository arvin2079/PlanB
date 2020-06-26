import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planb/src/utility/languageDetector.dart';

typedef void OnSaved(String string);
typedef String Validator(String string);

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {this.errorText,
      this.focusNode,
      this.controller,
      this.inputType,
      this.onSaved,
      this.validator,
      @required this.labelText,
      this.hintText,
      this.initialValue,
      this.maxLength});

  final String labelText;
  final String initialValue;
  final String hintText;
  final String errorText;
  final TextInputType inputType;
  final FocusNode focusNode;
  final OnSaved onSaved;
  final Validator validator;
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
        initialValue: widget.initialValue,
        controller: widget.controller,
        maxLength: widget.maxLength,
        focusNode: widget.focusNode,
        onSaved: widget.onSaved,
        validator: widget.validator,
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

class TextArea extends StatefulWidget {
  const TextArea({
    this.labelText,
    this.onSaved,
    this.validator,
  });

  final String labelText;
  final OnSaved onSaved;
  final Validator validator;

  @override
  _TextAreaState createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> with LanguageDetector {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: widget.validator,
        onSaved: widget.onSaved,
        style: Theme.of(context).textTheme.headline1,
        textDirection: TextDirection.rtl,
        keyboardType: TextInputType.multiline,
        maxLines: 7,
//        validator: (value) {
//          if (_isPersian)
//            return null;
//          else
//            return 'در این قیمت تنها مجاز به استفاده از حروف فارسی میباشید.';
//        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
