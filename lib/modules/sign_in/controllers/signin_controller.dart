import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:photo_social/routes/routes.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../global_widgets/index.dart';
import '../../../src/enum/index.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../../authentication/controllers/local_authentication_controller.dart';
import '../../sign_up/controllers/signup_controller.dart';

class SignInController extends GetxController {
  final AuthRepository _authRepository;
  final LocalAuthentication _authentication;
  SignInController(
      {@required AuthRepository authRepository, @required LocalAuthentication localAuthentication})
      : _authRepository = authRepository,
        _authentication = localAuthentication;
  var userNameCtrl = TextEditingController(text: "demo123");
  var passwordCtrl = TextEditingController(text: "Demo123@");
  var buttonController = LoadingButtonController();
  var authenticationStatus = AuthenticationStatus.unknown.obs;
  final showPassword = false.obs;
  var loginInputValidated = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future login() async {
    final userName = userNameCtrl.value.text;
    final password = passwordCtrl.value.text;

    try {
      final result = await _authRepository.signIn(userName: userName, password: password);
      if (result.success) {
        authenticationStatus(AuthenticationStatus.authenticated);
        buttonController.success();
        await setSession(result.data);
        toDestinationPage();
      }
    } catch (_) {
      buttonController.reset();
      authenticationStatus(AuthenticationStatus.unauthenticated);
    }
  }

  Future setSession(UserModel user) async {
    await _authentication.setSession(user);
  }

  void toDestinationPage() {
    if (authenticationStatus.value == AuthenticationStatus.authenticated) {
      Get.toNamed(Routes.HOME);
    } else
      buttonController.reset();
  }

  Future<void> signInWithGoogle() async {
    // login and get info with google
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final String userName = googleSignInAccount.displayName;
    final String email = googleSignInAccount.email;
    //set info to sign up screen
    SignUpController.to.setInfoViaGoogle(email: email, userName: userName);
    // move to sign up screen
    AuthController.to.tabController.animateTo(1);
  }

  void signInWithInstagram() {
    BotToast.showText(text: "On working feature");
  }

  void checkuserInput() {
    loginInputValidated.value = userNameCtrl.text.isNotEmpty && passwordCtrl.text.isNotEmpty;
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
