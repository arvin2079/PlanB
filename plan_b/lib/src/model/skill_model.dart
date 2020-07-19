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

class SkillRepository{
  List<Skill> skills;

  SkillRepository({this.skills});

  int findSkillCodeByName(name) {
    for (Skill s in skills) {
      if (s.name == name) {
        return s.code;
      }
    }
    return null;
  }

  String findSkillNameByCode(code){
    for(Skill s in skills){
      if(s.code == code){
        return s.name;
      }
    }
    return null;
  }

  List<String> getNames(){
    List result = <String>[];
    for (Skill s in skills){
      result.add(s.name);
    }
    return result;
  }

  List<int> getCodes(){
    List result = <int>[];
    for (Skill s in skills){
      result.add(s.code);
    }
    return result;
  }

}
