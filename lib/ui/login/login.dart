import 'package:bot_toast/bot_toast.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/theme/gradient.dart';
import 'package:photo_social/utils/social_icon.dart';
import 'package:photo_social/widgets/clickable_text.dart';
import 'package:photo_social/widgets/custom_button.dart';
import 'package:photo_social/widgets/custom_svg.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<SignInController>(
            init: SignInController(),
            builder: (_) {
              return SingleChildScrollView(
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              "Welcome Back",
                              style: AppStyle.wellcomeTextLogin,
                            ),
                            Spacer(),
                            CustomButton(
                              onPress: () {
                                _.skipLogin();
                              },
                              tooltip: "Skip login",
                              iconColor: Colors.grey,
                              width: 45,
                              height: 28,
                              radius: 10,
                              childs: [Text("Skip")],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        height: 50,
                        child: TextField(
                          controller: _.userName,
                          decoration: InputDecoration(
                              hintText: "Username or email",
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              fillColor: Colors.grey.withOpacity(0.2),
                              filled: true,
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 1, color: Colors.grey[400])),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        child: TextField(
                          controller: _.password,
                          decoration: InputDecoration(
                              hintText: "Password",
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              fillColor: Colors.grey.withOpacity(0.2),
                              filled: true,
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 1, color: Colors.grey[400])),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      CustomButton(
                        onPress: () {},
                        tooltip: "Sign In",
                        iconColor: Colors.indigo,
                        height: 50,
                        backgroundColor: Colors.indigo,
                        mainAxisAlignment: MainAxisAlignment.center,
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xff303F9F), Color(0xff666ad1)]),
                        width: Get.width,
                        childs: [
                          Flexible(
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Sign In", style: AppStyle.signInButtonText)),
                                ),
                                Positioned(right: 0, bottom: 0, child: CustomSVG()),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have account ? "),
                          ClickableText(
                              onTap: () {},
                              text: Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.indigo),
                              ))
                        ],
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                onPress: () {
                                  BotToast.showText(text: "On working feature");
                                },
                                tooltip: "Login with Google",
                                iconColor: Colors.white,
                                backgroundColor: Color(0xffFC5243),
                                icon: SocialIcon.google,
                                width: 50,
                                height: 50,
                              ),
                              CustomButton(
                                onPress: () {
                                  BotToast.showText(text: "On working feature");
                                },
                                tooltip: "Login with Facebook",
                                iconColor: Colors.white,
                                backgroundColor: Color(0xff3b5998),
                                icon: FeatherIcons.facebook,
                                width: 50,
                                height: 50,
                              ),
                              CustomButton(
                                onPress: () {
                                  BotToast.showText(text: "On working feature");
                                },
                                tooltip: "Login with Instagram",
                                iconColor: Colors.white,
                                backgroundColor: Colors.white,
                                gradient: AppGradient.instagram,
                                icon: SocialIcon.instagram,
                                width: 50,
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
