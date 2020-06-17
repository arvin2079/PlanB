import 'dart:convert';

import 'package:planb/src/bloc/bloc.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/resource/repository.dart';
import 'package:planb/src/utility/message_exception.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc {

  final repository = Repository();
  PublishSubject<AuthStatus> authStatusStreamController = PublishSubject();
  PublishSubject<String> errorsStreamController = PublishSubject();
  dynamic _lastStatus;

  UserBloc(){
    _lastStatus = authStatusStreamController.stream.shareValue();
    _lastStatus.listen(null);
  }


  Stream<AuthStatus> get authStatusStream =>
      authStatusStreamController.stream;

  Stream<String> get errorsStream => errorsStreamController.stream;
  AuthStatus get lastStatus => _lastStatus.value;

  signUpNewUser(User user) async {
    try {
      authStatusStreamController.sink.add(AuthStatus.loading);
      String token = await repository.getNewToken(user);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("token", token);
      authStatusStreamController.sink.add(AuthStatus.signedIn);
    } on MessagedException catch (e) {
      authStatusStreamController.sink.add(AuthStatus.signedOut);
      Map errors = jsonDecode(e.message);
      for (dynamic error in errors.values) {
        errorsStreamController.sink.add(error.toString());
      }
    } catch (e){
      authStatusStreamController.sink.add(AuthStatus.signedOut);
    }
  }

  login(String username, String password) async {
    try {
      authStatusStreamController.sink.add(AuthStatus.loading);
      Map data = await repository.login(username, password);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("token", data['token']);
      authStatusStreamController.sink.add(AuthStatus.signedIn);
    } on MessagedException catch (e){
      authStatusStreamController.sink.add(AuthStatus.signedOut);
      Map errors = jsonDecode(e.message);
      for(dynamic error in errors.values){
        errorsStreamController.sink.add(error[0]);
        print(error);
      }
    } catch (e){
      authStatusStreamController.sink.add(AuthStatus.signedOut);
    }
  }

  @override
  void dispose() {
    authStatusStreamController.close();
    errorsStreamController.close();
  }
}

UserBloc bloc = UserBloc();
