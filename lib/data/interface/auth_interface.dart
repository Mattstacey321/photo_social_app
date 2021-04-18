import '../models/base_result_model.dart';

abstract class IAuthRepository {
  Future<BaseResultModel> signIn({
    String userName,
    String password,
  });
  Future<BaseResultModel> signUp({
    String username,
    String password,
    String name,
  });
  Future<void> signOut();
  Future<bool> checkUserNameAvalibility({String name});
}
