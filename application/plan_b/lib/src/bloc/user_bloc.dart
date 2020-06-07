import 'package:planb/src/bloc/bloc.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/resource/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends Bloc{
  Repository repository = Repository();
  PublishSubject tokenStreamController = PublishSubject();

  Stream<String> get tokenStream => tokenStreamController.stream;

  signUpNewUser(User user) async{

    String token = await repository.getNewToken(user);
    tokenStreamController.sink.add(token);

  }

  @override
  void dispose() {
    tokenStreamController.close();
  }
}