import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/src/dialogs/index.dart';
import 'package:photo_social/themes/app_gradients.dart';
import 'package:photo_social/themes/app_styles.dart';
import 'package:photo_social/utils/social_icon.dart';
import 'package:photo_social/widgets/index.dart';
import 'package:photo_social/widgets/input/custom_input.dart';

import 'signin_controller.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double socialButtonSize = 45;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: GetBuilder<SignInController>(
                init: SignInController(),
                autoRemove: false,
                builder: (_) {
                  return Obx(
                    () => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          CustomInput(
                            controller: _.userNameCtrl,
                            hintText: "Username or email",
                            onChange: (s) => _.checkuserInput(),
                            prefix: Icon(EvaIcons.at),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomInput(
                            controller: _.passwordCtrl,
                            hintText: "Password",
                            onChange: (s) => _.checkuserInput(),
                            showPassword: !_.showPassword.value,
                            prefix: Icon(EvaIcons.lockOutline),
                            suffix: GestureDetector(
                                onTap: () => _.showPassword.toggle(),
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 250),
                                  child: _.showPassword.value
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
                          SizedBox(
                            height: 50,
                          ),
                          CustomButton(
                            onPress: () {
                              skipLogin();
                            },
                            tooltip: "Skip login",
                            iconColor: Colors.grey,
                            width: Get.width,
                            height: 45,
                            childs: [Text("Skip for now")],
                          ),
                          SizedBox(height: 10),
                          ObxValue((res) {
                            return LoadingButton(
                              controller: _.buttonController,
                              height: 45,
                              width: Get.width,
                              onPressed: res.value
                                  ? () {
                                      _.login();
                                    }
                                  : null,
                              initialWidget: Text(
                                "Login",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              successWidget: Icon(EvaIcons.checkmark),
                              errorWidget: Icon(EvaIcons.close),
                            );
                          }, _.loginInputValidated),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have account ? "),
                              GestureDetector(
                                  onTap: () {
                                    _.goToRegister();
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                          SizedBox(height: 20),
                          Spacer(),
                          Divider(),
                          SizedBox(height: 1),
                          Text(
                            "Or Sign Up with",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                onPress: () {
                                  _.signInWithGoogle();
                                },
                                tooltip: "Login with Google",
                                iconColor: Colors.white,
                                backgroundColor: Color(0xffFC5243),
                                icon: SocialIcon.google,
                                width: socialButtonSize,
                                height: socialButtonSize,
                              ),
                              /*CustomButton(
                                onPress: () {},
                                tooltip: "Login with Facebook",
                                iconColor: Colors.white,
                                backgroundColor: Color(0xff3b5998),
                                icon: SocialIcon.facebook_f,
                                width: socialButtonSize,
                                height: socialButtonSize,
                              ),*/
                              CustomButton(
                                onPress: () {
                                  _.signInWithInstagram();
                                },
                                tooltip: "Login with Instagram",
                                iconColor: Colors.white,
                                backgroundColor: Colors.white,
                                gradient: AppGradients.instagram,
                                icon: SocialIcon.instagram,
                                width: socialButtonSize,
                                height: socialButtonSize,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
