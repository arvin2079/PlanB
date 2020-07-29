class City {
  String code;
  String title;

  City({this.code, this.title});

  factory City.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return City(code: json['code'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    return data;
  }
}

class CityRepository {
  List<City> cities;

  CityRepository({this.cities});

  String findCityCodeByTitle(name) {
    for (City c in cities) {
      if (c.title == name) {
        return c.code;
      }
    }
    return null;
  }

  String findCityTitleByCode(code) {
    for (City c in cities) {
      if (c.code == code) {
        return c.title;
      }
    }
    return null;
  }

  List<String> getTitles() {
    List result = <String>[];
    for (City c in cities) {
      result.add(c.title);
    }
    return result;
  }
}
