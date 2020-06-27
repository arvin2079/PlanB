import 'package:planb/src/bloc/project_bloc.dart';
import 'package:planb/src/model/skill_model.dart';
import 'package:planb/src/model/user_model.dart';

class Project {
  int id;
  int creatorId;
  String name;
  List skillCodes;
  DateTime startDate;
  String image;
  String descriptions;
  bool activation;

  Project(
      {this.id,
      this.creatorId,
      this.name,
      this.skillCodes,
      this.startDate,
      this.image,
      this.descriptions,
      this.activation});

  factory Project.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Project(
        id: json['id'],
        creatorId: json['creator'],
        name: json['Project_name'],
        skillCodes: json['skills'] != null ? (json['skills'] as List) : null,
        startDate: DateTime.parse(json['StartDate']),
        image: json['image'],
        descriptions: json['descriptions'],
        activation: json['activation']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['creator'] = this.creatorId;
    data['Project_name'] = this.name;
    if (this.skillCodes != null) {
      data['skills'] = this.skillCodes.toList();
    }
    data['StartDate'] = this.startDate;
    data['image'] = this.image;
    data['descriptions'] = this.descriptions;
    data['activation'] = this.activation;
    return data;
  }

  @override
  String toString() {
    return 'Project{id: $id, creatorId: $creatorId, name: $name, skillCodes: $skillCodes, startDate: $startDate, image: $image, descriptions: $descriptions, activation: $activation}';
  }
}

ProjectBloc projectBloc = ProjectBloc();

class ProjectRepository {
  List<Project> projects;
}
