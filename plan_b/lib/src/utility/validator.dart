import 'package:planb/src/utility/languageDetector.dart';

abstract class StringValidator {
  bool isValid(String value);
}

class EmailValidator with LanguageDetector implements StringValidator {
  @override
  bool isValid(String value) {
    if (value.isEmpty || !hasEnglishChar(value)) return false;
    RegExp emailReg = RegExp(r'(?:\S)+@(?:\S)+\.(?:\S)+', caseSensitive: false);
    return emailReg.hasMatch(value);
  }
}

class PasswordValidator implements StringValidator {
  //just can user numeric and chars
  RegExp regExp = RegExp(r'[\d\w]+', caseSensitive: false);
  @override
  bool isValid(String value) {
    return value.length >= 6 && regExp.stringMatch(value) == value;
  }
}

class UsernameValidator with LanguageDetector implements StringValidator {
  //must be numeric or chars and cant be in persian
  RegExp regExp = RegExp(r'[\w]+', caseSensitive: false);
  @override
  bool isValid(String value) {
    return value.length >= 5 && regExp.stringMatch(value) == value;
  }
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class PhoneNumberStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    RegExp regExp = RegExp(r'09\d{9}');
    return regExp.hasMatch(value) && value.length == 10;
  }
}

class PersianValidator with LanguageDetector implements StringValidator {
  @override
  bool isValid(String value) {
    if(value.isEmpty || hasEnglishChar(value))
      return false;
    return true;
  }
}

class EnglishValidator with LanguageDetector implements StringValidator {
  @override
  bool isValid(String value) {
    if(value.isEmpty || !hasEnglishChar(value))
      return false;
    return true;
  }
}

class SignUpValidator {
  final StringValidator firstnameValidator = PersianValidator();
  final StringValidator lastnameValidator = PersianValidator();
  final StringValidator usernameValidator = EnglishValidator();
  final StringValidator uniIdValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final StringValidator emailValidator = EmailValidator();
  final String notValidEmailMessage = 'ایمیل غیر مجاز';
  final String notValidPasswordMessage = 'رمز عبور غیر مجاز';
  final String notValidUniIdMessage = 'کد دانشجویی غیر مجاز';
  final String notValidUsernameMessage = 'پر کردن این فیلد به زبان انگلیسی الزامیست';
  final String notValidFirstnameMessage = 'پر کردن این فیلد به زبان فارسی الزامیست';
  final String notValidLastnameMessage = 'پر کردن این فیلد به زبان فارسی الزامیست';
}

class LogInValidator {
  final StringValidator usernameValidator = UsernameValidator();
  final StringValidator passwordValidator = PasswordValidator();
  final String notValidUsernameMessage = 'نام کاربری غیر مجاز';
  final String notValidPasswordMessage = 'رمز عبور غیر مجاز';
}

class CompleteProfileValidator {
  //todo : vlaidator for instagram and telegram and... validator
  final StringValidator socialMediaIdValidator = NonEmptyStringValidator();
  final StringValidator descriptionValidator = PersianValidator();
  final String notValidUniIdMessage = 'کد دانشجویی غیر مجاز';
  final String notValidUsernameMessage = 'پر کردن این فیلد به زبان انگلیسی الزامیست';
  final String notValidFirstnameMessage = 'پر کردن این فیلد به زبان فارسی الزامیست';
  final String notValidLastnameMessage = 'پر کردن این فیلد به زبان فارسی الزامیست';
  final String notValidPhoneNumberErrorMassage = 'شماره همراه صحیح خود را وارد کنید';
  final String notValidSocialMediaErrorMassage = 'پر کردن این فیلد الزامیست';
  final String notValidDescriptionErrorMassage = 'پر کردن این فیلد به زبان فارسی الزامیست';
}
