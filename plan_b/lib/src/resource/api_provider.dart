import 'dart:convert';

import 'package:http/http.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/utility/message_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIProvider {
  final Client client = Client();

  // Header parameters for request
  String _baseUrl = "http://192.168.43.147:8000/";
  Map<String, String> headers = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };

  Future<String> signUpNewUser(User user) async {
    // Set request data
    String url = _baseUrl + "signup/";
    String json = jsonEncode(user.toJson());

    // Sending request
    final response = await client.post(url, headers: headers, body: json);

    if (response.statusCode == 200) {
      // Return new token on successful request
      return jsonDecode(response.body)['token'];
    } else {
      // Return error messages
      throw MessagedException(utf8.decode(response.bodyBytes));
    }
  }

  Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    // Set request data
    String url = _baseUrl + "api/token/";
    Map map = {"username": username, "password": password};
    String json = jsonEncode(map);

    // Sending request
    final response = await client.post(url, headers: headers, body: json);

    if (response.statusCode == 200) {
      // Return token on successful request
      Map<String, dynamic> json = jsonDecode(response.body);
      Map<String, dynamic> data = Map<String, dynamic>();
      data['token'] = json['token'];
      return data;
    } else {
      // Return error messages
      throw MessagedException(utf8.decode(response.bodyBytes));
    }
  }

  Future<Map> getCompleteProfileFields() async {
    // Load token for place in request
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = _baseUrl + "dashboard/edit_profile/";
    Map<String, String> headers = this.headers;
    headers['Authorization'] = "Token " + preferences.getString('token');
    // Sending request
    final response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      // Return data on successful request
      Map map = jsonDecode(utf8.decode(response.bodyBytes));
      return map;
    } else {
      // Return error messages
      throw MessagedException("Something went wrong");
    }
  }

  Future<Map> completeProfile(User requestUser) async {
    // Load token for place in request
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = _baseUrl + "dashboard/edit_profile/";
    Map<String, String> headers = this.headers;
    headers['Authorization'] = "Token " + preferences.getString('token');
    String body = jsonEncode(requestUser.toJson());
    // Sending request
    final response = await client.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      // Return data on successful request
      Map map = jsonDecode(utf8.decode(response.bodyBytes));
      if (map['errors'] == null) {
        return (map['username']);
      } else {
        throw MessagedException(map['errors']);
      }
    } else {
      // Return error messages
      throw MessagedException("Something went wrong");
    }
  }

  Future<Project> createNewProject(Project requestProject) async{
    // Load token for place in request
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = _baseUrl + "dashboard/newproject/";
    Map<String, String> headers = this.headers;
    headers['Authorization'] = "Token " + preferences.getString('token');
    String body = jsonEncode(requestProject.toJson());
    // Sending request
    final response = await client.post(url, headers: headers, body: body);

    if(response.statusCode == 201){
      Map map = jsonDecode(utf8.decode(response.bodyBytes));
      Project project = Project.fromJson(map);
      return project;
    } else {
      throw MessagedException("Something went wrong");
    }

  }


}
