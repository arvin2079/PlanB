import 'dart:convert';

class Skill{
  int code;
  String name;


  Skill({this.code, this.name});

  factory Skill.fromJson(Map<String, dynamic> json){
    return Skill(
      code: json['code'],
      name: json['skill_name'],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['code'] = this.code;
    data['skill_name'] = this.name;

    return data;
  }
}