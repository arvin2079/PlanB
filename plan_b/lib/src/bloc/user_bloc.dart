import 'dart:convert';

import 'package:planb/src/bloc/bloc.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/resource/repository.dart';
import 'package:planb/src/utility/message_exception.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc {
  Repository repository = Repository();
  PublishSubject tokenValidationStreamController = PublishSubject();
  PublishSubject errorsStreamController = PublishSubject();

  Stream<String> get tokenValidationStream =>
      tokenValidationStreamController.stream;

  Stream<String> get errorsStream => tokenValidationStreamController.stream;

  signUpNewUser(User user) async {
    try {
      String token = await repository.getNewToken(user);
      tokenValidationStreamController.sink.add(true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("token", token);
    } on MessagedException catch (e) {
      tokenValidationStreamController.sink.add(false);
      Map errors = jsonDecode(e.message);
      for (dynamic error in errors.values) {
        errorsStreamController.sink.add(error);
      }
    }
  }

  login(String username, String password) async {
    Map data = await repository.login(username, password);
    tokenValidationStreamController.sink.add(true);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", data['token']);
    // todo: save user info in a separate stream controller
    print(preferences.getString("token"));
  }

  @override
  void dispose() {
    tokenValidationStreamController.close();
    errorsStreamController.close();
  }
}

UserBloc bloc = UserBloc();
