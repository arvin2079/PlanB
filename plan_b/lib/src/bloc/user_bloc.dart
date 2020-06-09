import 'package:planb/src/bloc/bloc.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/resource/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc{
  Repository repository = Repository();
  PublishSubject tokenValidationStreamController = PublishSubject();

  Stream<String> get tokenValidationStream => tokenValidationStreamController.stream;

  signUpNewUser(User user) async{

    String token = await repository.getNewToken(user);
    tokenValidationStreamController.sink.add(true);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
  }

  login(String username, String password) async{
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
  }
}
UserBloc bloc = UserBloc();