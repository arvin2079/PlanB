import 'package:planb/src/model/city_model.dart';

class University{
  int code;
  String name;
  City city;


  University({this.code, this.name, this.city});

  factory University.fromJson(Map<String, dynamic> json){
    return University(
      code: json['code'],
      name: json['name'],
      city: City.fromJson(json['city'])
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['city'] = city.toJson();
    return data;
  }
}