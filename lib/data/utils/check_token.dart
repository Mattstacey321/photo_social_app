
import '../../modules/authentication/controllers/local_authentication_controller.dart';

Future<bool> isAuth() async {
  LocalAuthentication _authentication = LocalAuthentication();
  final result = await _authentication.getUserInfo();
  return !result.guest;
}
