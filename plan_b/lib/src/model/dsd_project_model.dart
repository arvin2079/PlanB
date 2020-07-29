import 'package:planb/src/model/cooperation_model.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/model/user_model.dart';

class DSDProject {
  Project project;
  List<DSDUser> users;
  List<Cooperation> cooperation;

  DSDProject({this.project, this.users, this.cooperation});

  factory DSDProject.fromJson(Map<String, dynamic> json) {
    return DSDProject(
        project: Project.fromJson(json['project']),
        users: json['users'] != null
            ? (json['users'] as List).map((i) => DSDUser.fromJson(i)).toList()
            : null,
        cooperation: json['cooperation'] != null
            ? (json['cooperation'] as List)
                .map((e) => Cooperation.fromJson(e))
                .toList()
            : null);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['project'] = this.project.toJson();
    data['users'] =
        this.users == null ? null : this.users.map((e) => e.toJson()).toList();
    data['cooperation'] = this.cooperation == null
        ? null
        : this.cooperation.map((e) => e.toJson()).toList();

    return data;
  }

  @override
  String toString() {
    return 'DSDProject{project: $project, users: $users, cooperation: $cooperation}';
  }
}

class DSDUser {
  int id;
  User user;

  DSDUser({this.id, this.user});

  factory DSDUser.fromJson(Map<String, dynamic> json) {
    return DSDUser(id: json['id'], user: User.fromJson(json['user_ser']));
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['user_ser'] = this.user.toJson();
    data['id'] = this.id;

    return data;
  }

  @override
  String toString() {
    return 'DSDUser{id: $id, user: $user}';
  }
}
