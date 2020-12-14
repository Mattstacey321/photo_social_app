import 'package:photo_social/modules/local_authentication/local_authentication_controller.dart';

Future<bool> isAuth() async {
  LocalAuthentication _authentication = LocalAuthentication();
  final result = await _authentication.getUserInfo();
  return !result.guest;
}
