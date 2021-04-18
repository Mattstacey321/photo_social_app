import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/themes/index.dart';
import '../../../global_widgets/index.dart';
import '../../../global_widgets/input/custom_input.dart';
import '../controllers/signup_controller.dart';

class SignUp extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: <Widget>[
                  Container(
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Create Account,",
                          style: AppStyles.wellcomeTextLogin,
                        ),
                        Text(
                          "Sign up to get started!",
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  CustomInput(
                    controller: controller.usernameCtrl,
                    hintText: "Username",
                    onChange: (s) => controller.checkUserName(),
                    prefix: Icon(
                      EvaIcons.person,
                    ),
                    suffix: AnimatedOpacity(
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      opacity: controller.userNameValidated.value ? 1 : 0,
                      child: LoadingButton(
                          controller: controller.buttonCheckAvailibity,
                          height: 40,
                          width: 40,
                          buttonColor: Colors.transparent,
                          onPressed: () {},
                          initialWidget: Text("")),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      CustomInput(
                        controller: controller.passwordCtrl,
                        hintText: "Password",
                        onChange: (s) => controller.checkPassword(),
                        prefix: Icon(EvaIcons.lockOutline),
                      ),
                      AnimatedSwitcher(
                        duration: 250.milliseconds,
                        child: !controller.passwordValidated.value
                            ? Container(
                                width: Get.width,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        AnimatedSwitcher(
                                          switchInCurve: Curves.easeIn,
                                          switchOutCurve: Curves.easeOut,
                                          duration: Duration(milliseconds: 200),
                                          child: controller.passwordLength.value
                                              ? Icon(
                                                  EvaIcons.checkmark,
                                                  size: 18,
                                                )
                                              : Icon(
                                                  EvaIcons.close,
                                                  color: Colors.red,
                                                  size: 18,
                                                ),
                                        ),
                                        SizedBox(width: 5),
                                        Text("8 to 16 character")
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        AnimatedSwitcher(
                                          switchInCurve: Curves.easeIn,
                                          switchOutCurve: Curves.easeOut,
                                          duration: Duration(milliseconds: 200),
                                          child: controller.specialCharValidated.value
                                              ? Icon(
                                                  EvaIcons.checkmark,
                                                  size: 18,
                                                )
                                              : Icon(
                                                  EvaIcons.close,
                                                  color: Colors.red,
                                                  size: 18,
                                                ),
                                        ),
                                        SizedBox(width: 5),
                                        Text("Must include upper character, symbol and number")
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(
                                height: 20,
                              ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Column(
                      children: [
                        CustomInput(
                          controller: controller.reTypePasswordCtrl,
                          hintText: "Re type password",
                          onChange: (s) => controller.checkPasswordMatch(),
                          prefix: Icon(EvaIcons.lockOutline),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AnimatedSwitcher(
                          switchInCurve: Curves.easeIn,
                          switchOutCurve: Curves.easeOut,
                          duration: Duration(milliseconds: 200),
                          child: controller.reTypePasswordValidated.value
                              ? SizedBox()
                              : Row(
                                  children: <Widget>[
                                    Icon(
                                      EvaIcons.close,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                    SizedBox(width: 5),
                                    Text("Password must be same. try again")
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      CustomInput(
                        controller: controller.emailCtrl,
                        hintText: "Email",
                        onChange: (s) => controller.checkEmail(),
                        prefix: Icon(EvaIcons.emailOutline),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Spacer(),
                  Obx(
                    () => LoadingButton(
                      controller: controller.buttonSignUp,
                      height: 45,
                      width: Get.width,
                      onPressed: controller.signUpValidate.value
                          ? () {
                              controller.signUp();
                            }
                          : null,
                      initialWidget: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                      successWidget: Icon(EvaIcons.checkmark),
                      errorWidget: Icon(EvaIcons.close),
                    ),
                  )
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
