import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String? username;
  String? password;

  User({
    this.id,
    this.username,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
      };

  static List<User> getStaticUser() {
    return [
      User(id: 1, username: "user011", password: "user011@"),
      User(id: 2, username: "user012", password: "user012@"),
      User(id: 3, username: "user013", password: "user013@"),
      User(id: 4, username: "user014", password: "user014@"),
      User(id: 5, username: "user015", password: "user015@")
    ];
  }

  static User? isExistingUser(String username, String password) {
    var users = getStaticUser();
    var user = users.where((element) =>
        element.username == username && element.password == password);
    if (user.isNotEmpty) {
      return user.first;
    }
    return null;
  }
}
