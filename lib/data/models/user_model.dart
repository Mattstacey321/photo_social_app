import '../../constraint.dart';

class UserModel {
  String userId;
  String name;
  String email;
  String avatar;
  String token;
  bool guest;
  UserModel(
      {this.userId,
      this.name,
      this.email,
      this.avatar,
      this.token,
      this.guest = false});

  UserModel.guest()
      : userId = null,
        guest = true,
        name = "Guest",
        email = null,
        avatar = AppConstraints.defaultAvatar,
        token = "";

  factory UserModel.fromJson(Map data) {
    return UserModel(
        userId: data["userId"],
        name: data['name'],
        email: data['email'],
        avatar: data['avatar'],
        token: data['token']);
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "avatar": avatar,
        "token": token,
      };
}
