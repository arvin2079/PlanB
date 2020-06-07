abstract class StringValidator {
  bool isValid(String value);
}

class EmailValidator implements StringValidator {
  @override
  bool isValid(String value) {
    if (value.isEmpty) return false;
    RegExp emailReg = RegExp(r'(?:\S)+@(?:\S)+\.(?:\S)+', caseSensitive: false);
    return emailReg.hasMatch(value);
  }
}

class PasswordValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.length >= 6;
  }
}

class UsernameValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.length >= 5;
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
    RegExp regExp = RegExp(r'9\d{9}');
    return regExp.hasMatch(value) && value.length == 10;
  }
}

class SignUpValidator {
  final StringValidator firstnameValidator = NonEmptyStringValidator();
  final StringValidator lastnameValidator = NonEmptyStringValidator();
  final StringValidator uniId = NonEmptyStringValidator();
  final StringValidator usernameValidator = UsernameValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final StringValidator emailValidator = EmailValidator();
  final String notValidEmailMessage = 'ایمیل غیر مجاز';
  final String notValidPasswordMessage = 'رمز عبور غیر مجاز';
  final String notValidUsernameMessage = 'نام کاربری غیر مجاز';
  final String notValidUniIdMessage = 'کد دانشجویی غیر مجاز';
  final String notValidFirstnameMessage = 'پر کردن این بخش الزامیست';
  final String notValidLastnameMessage = 'پر کردن این بخش الزامیست';
}

class SignInValidator {
  final StringValidator usernameValidator = UsernameValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String notValidUsernameMessage = 'نام کاربری غیر مجاز';
  final String notValidPasswordMessage = 'رمز عبور غیر مجاز';
}

class ProfileEditingValidator {
  final StringValidator firstnameValidator = NonEmptyStringValidator();
  final StringValidator lastnameValidator = NonEmptyStringValidator();
  final StringValidator usernameValidator = NonEmptyStringValidator();
  final StringValidator phoneNumberValidator = PhoneNumberStringValidator();
  final String inValidFirstnameErrorMassage = 'نام کوچک صحیح خود را وارد کنید';
  final String inValidLastnameErrorMassage = 'نام خوانوادگی صحیح خود را وارد کنید';
  final String inValidUsernameErrorMassage = 'نام کاربری صحیح خود را وارد کنید';
  final String inValidPhoneNumberErrorMassage = 'شماره همراه صحیح خود را وارد کنید';
}
