import 'package:get/get.dart';
import 'package:photo_social/constraint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  String getAvatar() {
    bool isSkipLogin = Get.find<SharedPreferences>().getBool('isSkipLogin');
    return isSkipLogin
        ? AppConstraint.defaultAvatar
        : Get.find<SharedPreferences>().getString("userAvatar");
  }
  String getName(){
    bool isSkipLogin = Get.find<SharedPreferences>().getBool('isSkipLogin');
    return isSkipLogin
        ? "Guest"
        : Get.find<SharedPreferences>().getString("userName");
  }
}
