import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_social/ui/login/widgets/skip_login_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();


  void login() {
    var userName = userNameCtrl.value;
    var password = passwordCtrl.value;
    
  }

  void signInWithGoogle() {

  }
  void signInWithInstagram(){
    
  }
}
