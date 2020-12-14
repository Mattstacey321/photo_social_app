import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/themes/app_styles.dart';
import 'package:photo_social/widgets/index.dart';
import 'package:photo_social/widgets/input/custom_input.dart';

import 'signup_controller.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: GetBuilder<SignUpController>(
                init: SignUpController(),
                autoRemove: false,
                builder: (_) {
                  return Padding(
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
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Obx(
                          () {
                            return CustomInput(
                              controller: _.usernameCtrl,
                              hintText: "Username",
                              onChange: (s) => _.checkUserName(),
                              prefix: Icon(
                                EvaIcons.person,
                              ),
                              suffix: AnimatedOpacity(
                                duration: Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                                opacity: _.userNameValidated.value ? 1 : 0,
                                child: LoadingButton(
                                    controller: _.buttonCheckAvailibity,
                                    height: 40,
                                    width: 40,
                                    buttonColor: Colors.transparent,
                                    onPressed: () {},
                                    initialWidget: Text("")),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => Column(
                            children: [
                              CustomInput(
                                controller: _.passwordCtrl,
                                hintText: "Password",
                                onChange: (s) => _.checkPassword(),
                                prefix: Icon(EvaIcons.lockOutline),
                              ),
                              AnimatedSwitcher(
                                duration: 250.milliseconds,
                                child: !_.passwordValidated.value
                                    ? Container(
                                        width: Get.width,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                AnimatedSwitcher(
                                                  switchInCurve: Curves.easeIn,
                                                  switchOutCurve:
                                                      Curves.easeOut,
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  child: _.passwordLength.value
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
                                                  switchOutCurve:
                                                      Curves.easeOut,
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  child: _.specialCharValidated
                                                          .value
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
                                                Text(
                                                    "Must include upper character, symbol and number")
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
                        ),
                        Obx(
                          () => Column(
                            children: [
                              CustomInput(
                                controller: _.reTypePasswordCtrl,
                                hintText: "Re type password",
                                onChange: (s) => _.checkPasswordMatch(),
                                prefix: Icon(EvaIcons.lockOutline),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AnimatedSwitcher(
                                switchInCurve: Curves.easeIn,
                                switchOutCurve: Curves.easeOut,
                                duration: Duration(milliseconds: 200),
                                child: _.reTypePasswordValidated.value
                                    ? SizedBox()
                                    : Row(
                                        children: <Widget>[
                                          Icon(
                                            EvaIcons.close,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                              "Password must be same. try again")
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
                              controller: _.emailCtrl,
                              hintText: "Email",
                              onChange: (s) => _.checkEmail(),
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
                            controller: _.buttonSignUp,
                            height: 45,
                            width: Get.width,
                            onPressed: _.signUpValidate.value
                                ? () {
                                    _.signUp();
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
