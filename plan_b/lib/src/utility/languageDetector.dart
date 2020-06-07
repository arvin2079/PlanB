class LanguageDetector {

  bool hasEnglishChar(String string) {
    RegExp reg = RegExp(r'\w');
    return reg.hasMatch(string);
  }

}
