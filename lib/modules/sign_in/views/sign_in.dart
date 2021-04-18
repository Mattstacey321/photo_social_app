import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/themes/app_gradients.dart';
import '../../../data/themes/app_styles.dart';
import '../../../data/utils/social_icon.dart';
import '../../../global_widgets/button/custom_button.dart';
import '../../../global_widgets/index.dart';
import '../../../global_widgets/input/custom_input.dart';
import '../../../src/dialogs/index.dart';
import '../controllers/signin_controller.dart';

class SignIn extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    const double socialButtonSize = 45;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome,",
                              style: AppStyles.wellcomeTextLogin,
                            ),
                            Text(
                              "Sign in to continue!",
                              style: TextStyle(color: Colors.grey.shade500, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          CustomButton(
                            onPress: () {
                              controller.signInWithGoogle();
                            },
                            tooltip: "Login with Google",
                            iconColor: Colors.white,
                            backgroundColor: Color(0xffFC5243),
                            icon: SocialIcon.google,
                            width: socialButtonSize,
                            height: socialButtonSize,
                          ),
                          SizedBox(width: 20),
                          /*CustomButton(
                                onPress: () {},
                                tooltip: "Login with Facebook",
                                iconColor: Colors.white,
                                backgroundColor: Color(0xff3b5998),
                                icon: SocialIcon.facebookcontrollerf,
                                width: socialButtonSize,
                                height: socialButtonSize,
                              ),*/
                          CustomButton(
                            onPress: () {
                              controller.signInWithInstagram();
                            },
                            tooltip: "Login with Instagram",
                            iconColor: Colors.white,
                            backgroundColor: Colors.white,
                            gradient: AppGradients.instagram,
                            icon: SocialIcon.instagram,
                            width: socialButtonSize,
                            height: socialButtonSize,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Or",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Expanded(child: _buildInput()),
                      CustomButton(
                        onPress: () {
                          skipLogin();
                        },
                        tooltip: "Skip login",
                        iconColor: Colors.grey,
                        width: Get.width / 4,
                        height: 50,
                        childs: [Text("Skip for now")],
                      ),
                      SizedBox(height: 10),
                      ObxValue((res) {
                        return LoadingButton(
                          controller: controller.buttonController,
                          height: 50,
                          width: Get.width / 4,
                          onPressed: res.value
                              ? () {
                                  controller.login();
                                }
                              : null,
                          initialWidget: Text(
                            "Login",
                          ),
                          successWidget: Icon(EvaIcons.checkmark),
                          errorWidget: Icon(EvaIcons.close),
                        );
                      }, controller.loginInputValidated),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have account ?"),
                          GestureDetector(
                              onTap: () {
                                controller.goToRegister();
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomInput(
          controller: controller.userNameCtrl,
          width: Get.width / 3,
          hintText: "Username or email",
          onChange: (s) => controller.checkuserInput(),
          prefix: Icon(EvaIcons.at),
        ),
        SizedBox(
          height: 20,
        ),
        CustomInput(
          controller: controller.passwordCtrl,
          hintText: "Password",
          width: Get.width / 3,
          onChange: (s) => controller.checkuserInput(),
          showPassword: !controller.showPassword.value,
          prefix: Icon(EvaIcons.lockOutline),
          suffix: GestureDetector(
              onTap: () => controller.showPassword.toggle(),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: controller.showPassword.value
                    ? Icon(
                        EvaIcons.eyeOff,
                        key: UniqueKey(),
                      )
                    : Icon(
                        EvaIcons.eye,
                        key: UniqueKey(),
                      ),
              )),
        ),
        Container(
          width: Get.width / 3,
          child: Row(
            children: <Widget>[
              Checkbox(
                value: false,
                onChanged: (value) {},
              ),
              Text("Remember Me"),
              Spacer(),
              InkWell(
                onTap: () {},
                child: Text("Forgot Password"),
              )
            ],
          ),
        ),
      ],
    );
  }
}
