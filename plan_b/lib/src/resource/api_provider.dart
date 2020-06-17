import 'dart:convert';
import 'package:http/http.dart';
import 'package:planb/src/model/user_model.dart';

class APIProvider{
  final Client client = Client();
  String _baseUrl = "http://192.168.43.147:8000/";


  Future<String> signUpNewUser(User user) async{
    String url = _baseUrl + "signup/";
    Map<String, String> headers = {"Content-type" : "application/json","Accept" : "application/json"};
    String json = jsonEncode(user.toJson());

    print((json));

    final response = await client.post(url, headers: headers, body: json);

    print(response.statusCode);

    if (response.statusCode == 200){
      return response.body;
    }
    else{
      throw Exception("Something went wrong!");
    }

  }

}