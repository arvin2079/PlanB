class MessagedException implements Exception {
  MessagedException(this._message);

  String _message;

  String get message => _message;
}
