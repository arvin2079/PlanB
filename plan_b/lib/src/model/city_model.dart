class City {
  String code;
  String title;

  City({this.code, this.title});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(code: json['code'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    return data;
  }
}
