import '../models/user_model.dart';

abstract class IGraphpl {
  Future<String> getToken();
  Future<UserModel> getUserInfo();
}
