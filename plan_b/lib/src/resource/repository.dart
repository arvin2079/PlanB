import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/resource/api_provider.dart';

class Repository{

  APIProvider _provider = APIProvider();
  Future<String> getNewToken(User user) => _provider.signUpNewUser(user);
  Future<Map<String, dynamic>> login(String username, String password) => _provider.loginUser(username, password);

}