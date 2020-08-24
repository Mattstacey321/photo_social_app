import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
