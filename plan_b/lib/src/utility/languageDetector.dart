class LanguageDetector {
  bool hasEnglishChar(String string) {
    RegExp reg = RegExp(r'\w');
    return reg.hasMatch(string);
  }

  bool isEnglish(String string) {
    RegExp reg = RegExp(r'\w');

    for(int i=0 ; i< string.length ; i++) {
      if(!reg.hasMatch(string.substring(i,i+1)))
        return false;
    }
    return true;
  }
}
