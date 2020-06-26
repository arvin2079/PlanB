import 'package:planb/src/model/project_model.dart';

enum AuthStatus { signedOut, loading, signedIn }

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
  List<int> skillCodes;
  List<Project> projects;
  int universityCode;
  String cityCode;
  String phoneNumber;
  bool isSuperUser;
  bool isStaff;
  String descriptions;

  User(
      {this.studentCode,
      this.username,
      this.password,
      this.email,
      this.firstName,
      this.lastName,
      this.dateJoined,
      this.avatar,
      this.gender,
      this.skillCodes,
      this.projects,
      this.universityCode,
      this.cityCode,
      this.phoneNumber,
      this.isSuperUser,
      this.isStaff,
      this.descriptions});

  factory User.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

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
        skillCodes:
            json['skills'] != null ? (json['skills'] as List).toList() : null,
        projects: json['projects'] != null
            ? (json['projects'] as List)
                .map((i) => Project.fromJson(i))
                .toList()
            : null,
        universityCode: json['university'],
        cityCode: json['city'].toString(),
        phoneNumber: json['phone_number'],
        isSuperUser: json['is_super_user'],
        descriptions: json['descriptions'],
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
    if (this.skillCodes != null) {
      data['skills'] = this.skillCodes.toList();
    }
    if (this.projects != null) {
      data['projects'] = this.projects.map((v) => v.toJson()).toList();
    }
    data['university'] = this.universityCode;
    data['city'] = this.cityCode;
    data['phone_number'] = this.phoneNumber;
    data['is_super_user'] = this.isSuperUser;
    data['is_staff'] = this.isStaff;
    data['descriptions'] = this.descriptions;

    return data;
  }

  @override
  String toString() {
    return 'User{studentCode: $studentCode, username: $username, email: $email, firstName: $firstName, lastName: $lastName, avatar: $avatar, gender: $gender, skills: $skillCodes, projects: $projects, university: $universityCode, city: $cityCode, phoneNumber: $phoneNumber, desc : $descriptions}';
  }
}
