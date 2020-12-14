import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_social/modules/authentication/auth_repository.dart';
import 'package:photo_social/widgets/index.dart';

class SignUpController extends GetxController {
  AuthRepository _authRepository = AuthRepository();
  LoadingButtonController buttonSignUp = LoadingButtonController();
  LoadingButtonController buttonCheckAvailibity = LoadingButtonController();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController reTypePasswordCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  var passwordValidated = false.obs;
  var passwordLength = false.obs;
  var reTypePasswordValidated = false.obs;
  var userNameValidated = false.obs;
  var emailValidated = false.obs;
  var specialCharValidated = false.obs;
  var signUpValidate = false.obs;

  Future signUp({String userName, String password, String email}) async {
    BotToast.showText(text: "On Working Feature");
  }

  void checkUserName() async {
    buttonCheckAvailibity.reset();
    userNameValidated.value = GetUtils.isUsername(usernameCtrl.text);
    //check user name after 2 second
    debounce(userNameValidated, (value) {
      return value == true ? checkUserNameAvalibility() : null;
    }, time: 2.seconds);
  }

  void checkUserNameAvalibility() async {
    buttonCheckAvailibity.start();
    if (userNameValidated.value) {
      await _authRepository
          .checkUserNameAvalibility(name: usernameCtrl.text)
          .timeout(
            4.seconds,
            onTimeout: () => buttonCheckAvailibity.reset(),
          )
          .then(
              (value) => value
                  ? buttonCheckAvailibity.success()
                  : buttonCheckAvailibity.error(),
              onError: (err) => buttonCheckAvailibity.error());
    }
  }

  void checkPassword() {
    passwordLength.value =
        GetUtils.isLengthGreaterOrEqual(passwordCtrl.text, 8);
    specialCharValidated.value = GetUtils.hasMatch(
        passwordCtrl.text, r'(?=.*?[0-9])(?=.*?[A-Z])(?=.*?[#?!@$%^&*-])');
    passwordValidated.value =
        passwordLength.value && specialCharValidated.value;
  }

  void checkPasswordMatch() {
    reTypePasswordValidated.value =
        passwordCtrl.text == reTypePasswordCtrl.text;
    print(passwordCtrl.text == reTypePasswordCtrl.text);
  }

  void checkEmail() {
    emailValidated.value = emailCtrl.text.isEmail;
  }
}
