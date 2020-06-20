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
  PublishSubject<List> errorsStreamController = PublishSubject();
  PublishSubject<List> skillsStreamController = PublishSubject();
  dynamic _lastStatus;

  UserBloc(){
    _lastStatus = authStatusStreamController.stream.shareValue();
    _lastStatus.listen(null);
  }


  Stream<AuthStatus> get authStatusStream =>
      authStatusStreamController.stream;

  Stream<List> get errorsStream => errorsStreamController.stream;
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
      Map errorsMap = jsonDecode(e.message);
      List<String> errorsList = List();
      errorsMap.forEach((k , v ) => errorsList.add(v.toString()));
      errorsStreamController.sink.add(errorsList);
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
      Map errorsMap = jsonDecode(e.message);
      List<String> errorsList = List();
      errorsMap.forEach((k , v ) =>errorsList.add(v.toString()));
      errorsStreamController.sink.add(errorsList);
    } catch (e){
      authStatusStreamController.sink.add(AuthStatus.signedOut);
    }
  }


  getCompleteProfileFields() async{
    try{
      final response = await repository.getCompleteProfileFields();
    }
    catch (e){}
  }


  @override
  void dispose() {
    skillsStreamController.close();
    authStatusStreamController.close();
    errorsStreamController.close();
  }
}

UserBloc bloc = UserBloc();
