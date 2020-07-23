import 'package:planb/src/model/cooperation_model.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/model/user_model.dart';

class DSDProject {
  Project project;
  List<User> users;
  List<Cooperation> cooperation;

  DSDProject({this.project, this.users, this.cooperation});

  factory DSDProject.fromJson(Map<String, dynamic> json) {
    return DSDProject(
        project: json['project'],
        users: json['users'] != null
            ? (json['users'] as List).map((i) => User.fromJson(i)).toList()
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
