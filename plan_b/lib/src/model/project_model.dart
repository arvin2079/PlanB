import 'package:planb/src/bloc/project_bloc.dart';
import 'package:planb/src/model/user_model.dart';

class Project {
  int id;
  User creator;
  String name;
  List skillCodes;
  DateTime startDate;
  String image;
  String descriptions;
  bool activation;
  List users;

  Project(
      {this.id,
      this.creator,
      this.name,
      this.skillCodes,
      this.startDate,
      this.image,
      this.descriptions,
      this.activation,
      this.users});

  factory Project.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Project(
        id: json['id'],
        creator: User.fromJson(json['creator']),
        name: json['Project_name'],
        skillCodes: json['skills'] != null ? (json['skills'] as List) : null,
        startDate: json['StartDate'] != null
            ? DateTime.parse(json['StartDate'])
            : null,
        image: json['image'],
        descriptions: json['descriptions'],
        activation: json['activation'],
        users: json['user_set'] != null
            ? (json['user_set'] as List).map((e) => User.fromJson(e)).toList()
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['creator'] = this.creator != null ? this.creator.toJson() : null;
    data['Project_name'] = this.name;
    if (this.skillCodes != null) {
      data['skills'] = this.skillCodes.toList();
    }
    data['StartDate'] = this.startDate;
    data['image'] = this.image;
    data['descriptions'] = this.descriptions;
    data['activation'] = this.activation;
    data['user_set'] = this.users;
    return data;
  }

  @override
  String toString() {
    return 'Project{id: $id, creatorId: $creator, name: $name, skillCodes: $skillCodes, startDate: $startDate, image: $image, descriptions: $descriptions, activation: $activation}';
  }
}

ProjectBloc projectBloc = ProjectBloc();

class ProjectRepository {
  List<Project> projects;
}
