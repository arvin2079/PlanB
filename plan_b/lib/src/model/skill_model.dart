class Skill {
  int id;
  int code;
  String name;

  Skill({this.id, this.code, this.name});

  factory Skill.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Skill(
      id: json['id'],
      code: json['code'],
      name: json['skill_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['code'] = this.code;
    data['skill_name'] = this.name;

    return data;
  }
}
