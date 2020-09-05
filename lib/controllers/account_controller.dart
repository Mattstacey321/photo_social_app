import 'package:get/get.dart';
import 'package:photo_social/constraint.dart';
import 'package:photo_social/controllers/controller.dart';

class AccountController extends GetxController {
  String getAvatar() {
    bool isSkipLogin = PreferencesController.getPrefs.getBool('isSkipLogin');
    return isSkipLogin
        ? AppConstraint.defaultAvatar
        : PreferencesController.getPrefs.getString("userAvatar");
  }

  String getName() {
    bool isSkipLogin = PreferencesController.getPrefs.getBool('isSkipLogin');
    return isSkipLogin
        ? "Guest"
        : PreferencesController.getPrefs.getString("userName");
  }
}
