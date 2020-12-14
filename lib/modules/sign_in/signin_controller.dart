import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/models/user_model.dart';
import 'package:photo_social/modules/authentication/auth_repository.dart';
import 'package:photo_social/modules/local_authentication/local_authentication_controller.dart';
import 'package:photo_social/widgets/index.dart';

import '../authentication/auth_controller.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class SignInController extends GetxController {
  AuthRepository _authRepository = AuthRepository();
  LocalAuthentication _authentication = LocalAuthentication();
  TextEditingController userNameCtrl = TextEditingController(text: "demo123");
  TextEditingController passwordCtrl = TextEditingController(text: "Demo123@");
  LoadingButtonController buttonController = LoadingButtonController();
  var authenticationStatus = AuthenticationStatus.unknown.obs;
  final showPassword = false.obs;
  var loginInputValidated = false.obs;

  Future login() async {
    var userName = userNameCtrl.value.text;
    var password = passwordCtrl.value.text;

    try {
      final result =
          await _authRepository.signIn(userName: userName, password: password);
      if (result.success) {
        authenticationStatus(AuthenticationStatus.authenticated);
        buttonController.success();
        await setSession(result.data);
        toDestinationPage();
      }
    } catch (e) {
      buttonController.reset();
      authenticationStatus(AuthenticationStatus.unauthenticated);
      //BotToast.showText(text: "${result.message}, try again");
    }
  }

  Future setSession(UserModel user) async {
    await _authentication.setSession(user);
  }

  void toDestinationPage() {
    if (authenticationStatus.value == AuthenticationStatus.authenticated) {
      Get.toNamed("/home");
    } else
      buttonController.reset();
  }

  void signInWithGoogle() {
    BotToast.showText(text: "On working feature");
  }

  void signInWithInstagram() {
    BotToast.showText(text: "On working feature");
  }

  void checkuserInput() {
    loginInputValidated.value =
        userNameCtrl.text.isNotEmpty && passwordCtrl.text.isNotEmpty;
  }

  void goToRegister() {
    AuthController.to.goToRegister();
  }

  @override
  void onInit() {
    // for remember last login...
    checkuserInput();
    super.onInit();
  }
}
