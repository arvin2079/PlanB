import 'package:planb/src/model/skill_model.dart';
import 'package:planb/src/model/user_model.dart';

class Project {
  User creator;
  String name;
  Skill skill;
  DateTime startDate;
  String image;
  String descriptions;

  Project(
      {this.creator,
      this.name,
      this.skill,
      this.startDate,
      this.image,
      this.descriptions});

  factory Project.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Project(
        creator: User.fromJson(json['creator']),
        name: json['name'],
        skill: Skill.fromJson(json['skill']),
        startDate: json['start_date'],
        image: json['image'],
        descriptions: json['description']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['creator'] = this.creator;
    data['name'] = this.name;
    if (this.skill != null) {
      data['skill'] = skill.toJson();
    }
    data['start_date'] = this.startDate;
    data['image'] = this.image;
    data['description'] = this.descriptions;

    return data;
  }
}
class ProjectRepository{
  List<Project> projects;
}
