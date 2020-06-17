import 'dart:convert';
import 'package:http/http.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/utility/message_exception.dart';

class APIProvider {
  final Client client = Client();
  String _baseUrl = "http://192.168.43.147:8000/";
  Map<String, String> headers = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };

  Future<String> signUpNewUser(User user) async {
    String url = _baseUrl + "signup/";
    String json = jsonEncode(user.toJson());

    final response = await client.post(url, headers: headers, body: json);

    print(response.statusCode);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['token'];
    } else {
      throw MessagedException(utf8.decode(response.bodyBytes));
    }
  }

  Future<Map<String, dynamic>> loginUser(String username, String password) async{
    String url = _baseUrl + "api/token/" ;
    Map map = {"username" : username, "password" : password};
    String json = jsonEncode(map);

    print(json);

    final response = await client.post(url, headers: headers, body: json);

    print(response.statusCode);

    if(response.statusCode == 200){
      Map<String, dynamic> json = jsonDecode(response.body);
      Map<String, dynamic> data = Map<String, dynamic>();
      data['token'] = json['token'];
      return data;
    }
    else {
      throw MessagedException(utf8.decode(response.bodyBytes));
    }
  }
}
