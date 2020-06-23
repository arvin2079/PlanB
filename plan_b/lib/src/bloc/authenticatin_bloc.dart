import 'package:planb/src/bloc/bloc.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc extends Bloc{

  PublishSubject<AuthStatus> _authStatusStreamController = PublishSubject();

  Stream<AuthStatus> get authenticationStatusStream => _authStatusStreamController.stream;


  isUserLoggedIn() async{
    _authStatusStreamController.sink.add(AuthStatus.loading);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString('token'));
    if(preferences.getString('token') != null){
      //todo Check validation of token
      _authStatusStreamController.sink.add(AuthStatus.signedIn);
    } else{
      _authStatusStreamController.sink.add(AuthStatus.signedOut);
    }
  }

  @override
  void dispose() {
    _authStatusStreamController.close();
  }
}

AuthenticationBloc authenticationBloc = AuthenticationBloc();