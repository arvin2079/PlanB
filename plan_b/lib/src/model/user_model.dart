import 'package:planb/src/model/city_model.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/model/skill_model.dart';
import 'package:planb/src/model/university_model.dart';

enum UserAuthenticationStatus{
  signedOut,
  loading,
  signedIn
}

class User {
  String studentCode;
  String username;
  String password;
  String email;
  String firstName;
  String lastName;
  DateTime dateJoined;
  String avatar;
  bool gender;
  List<Skill> skills;
  List<Project> projects;
  University university;
  City city;
  String phoneNumber;
  bool isSuperUser;
  bool isStaff;

  User(
      {
        this.studentCode,
        this.username,
      this.password,
      this.email,
      this.firstName,
      this.lastName,
      this.dateJoined,
      this.avatar,
      this.gender,
      this.skills,
      this.projects,
      this.university,
      this.city,
      this.phoneNumber,
      this.isSuperUser,
      this.isStaff});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        studentCode: json['student_code'],
        username: json['username'],
        password: json['password'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        dateJoined: json['date_joined'],
        avatar: json['avatar'],
        gender: json['gender'],
        skills: json['skills'] != null
            ? (json['skills'] as List).map((i) => Skill.fromJson(i)).toList()
            : null,
        projects: json['projects'] != null
            ? (json['projects'] as List)
                .map((i) => Project.fromJson(i))
                .toList()
            : null,
        university: University.fromJson(json['university']),
        city: City.fromJson(json['city']),
        phoneNumber: json['phone_number'],
        isSuperUser: json['is_super_user'],
        isStaff: json['is_staff']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_code'] = this.studentCode;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['date_joined'] = this.dateJoined;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    if (this.skills != null) {
      data['skills'] = this.skills.map((v) => v.toJson()).toList();
    }
    if (this.projects != null) {
      data['projects'] = this.projects.map((v) => v.toJson()).toList();
    }
    if (this.university != null){
      data['university'] = this.university.toJson();
    }
    if (this.city != null){
      data['city'] = this.city.toJson();
    }
    data['phone_number'] = this.phoneNumber;
    data['is_super_user'] = this.isSuperUser;
    data['is_staff'] = this.isStaff;

    return data;
  }
}
