
class User {
    String avatar;
    String city;
    String email;
    String firstName;
    bool gender;
    String lastName;
    String phoneNumber;
    List<String> grades;
    String username;
    String password;

    User({this.avatar, this.city, this.email, this.firstName, this.gender, this.lastName, this.phoneNumber, this.grades, this.username});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            avatar: json['avatar'],
            city: json['city'],
            email: json['email'],
            firstName: json['first_name'],
            gender: json['gender'],
            lastName: json['last_name'],
            phoneNumber: json['phone_number'],
//            projects: json['projects'] != null ? (json['projects'] as List).map((i) => Object.fromJson(i)).toList() : null,
            grades: null,
            username: json['username'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['avatar'] = this.avatar;
        data['city'] = this.city;
        data['email'] = this.email;
        data['first_name'] = this.firstName;
        data['gender'] = this.gender;
        data['last_name'] = this.lastName;
        data['phone_number'] = this.phoneNumber;
        data['username'] = this.username;
        data['password'] = this.password;
        if (this.grades != null) {
            data['grades'] = this.grades.map((v) => v.toString()).toList();
        }
        return data;
    }
}