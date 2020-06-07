import 'dart:convert';

import 'package:http/http.dart';
import 'package:planb/src/model/user_model.dart';

class APIProvider{
  final Client client = Client();
  String _baseUrl = "http://tabbesh.ir:83/";


  Future<String> signUpNewUser(User user) async{
    String url = _baseUrl + "api/token/";
    Map<String, String> headers = {"Content-type" : "application/json"};
    String json = jsonEncode(user.toJson());

    final response = await client.post(url, headers: headers, body: json);

    if (response.statusCode == 200){
      return response.body;
    }
    else{
      throw Exception("Something went wrong!");
    }

  }

}