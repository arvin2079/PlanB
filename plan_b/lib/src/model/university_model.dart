import 'package:planb/src/model/city_model.dart';

class University{
  int id;
  int code;
  String name;
  City city;

  Map<String, University> universitiesMap = Map();

  University({this.id, this.code, this.name, this.city});

  factory University.fromJson(Map<String, dynamic> json){
    if (json == null) return null;
    return University(
      id: json['id'],
      code: json['Code'],
      name: json['University_name'],
      city: City.fromJson(json['University_city'])
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['Code'] = this.code;
    data['University_name'] = this.name;
    if(this.city != null){
      data['University_city'] = city.toJson();
    }
    return data;
  }

}