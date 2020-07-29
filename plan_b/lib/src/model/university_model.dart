class University {
  int id;
  int code;
  String name;
  int cityCode;

  Map<String, University> universitiesMap = Map();

  University({this.id, this.code, this.name, this.cityCode});

  factory University.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return University(
        id: json['id'],
        code: json['Code'],
        name: json['University_name'],
        cityCode: json['University_city']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['Code'] = this.code;
    data['University_name'] = this.name;
    data['University_city'] = this.cityCode;
    return data;
  }
}

class UniversityRepository {
  List<University> universities;

  UniversityRepository({this.universities});

  int findUniversityCodeByName(name) {
    for (University u in universities) {
      if (u.name == name) {
        return u.code;
      }
    }
    return null;
  }

  String findUniversityNameByCode(code) {
    for (University u in universities) {
      if (u.code == code) {
        return u.name;
      }
    }
    return null;
  }

  List<String> getNames() {
    List result = <String>[];
    for (University u in universities) {
      result.add(u.name);
    }
    return result;
  }
}
