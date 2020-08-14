class UserModel {
  String fullName;
  String email;
  String avatar;
  UserModel({this.fullName, this.email, this.avatar});
  factory UserModel.fromJson(Map data) {
    return UserModel(fullName: data['fullName'], email: data['email'], avatar: data['avatar']);
  }
}
