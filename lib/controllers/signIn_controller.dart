import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_social/ui/login/widgets/skip_login_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  void skipLogin() {
    Get.find<SharedPreferences>().setBool("isSkipLogin", true);
    Get.find<SharedPreferences>().setString("token", "");
    Get.defaultDialog(content: SkipLoginDialog());
  }
}
