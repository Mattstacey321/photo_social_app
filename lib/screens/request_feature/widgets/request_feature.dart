import 'package:bot_toast/bot_toast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/fonts.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/widgets/custom_appBar.dart';
import 'package:photo_social/widgets/custom_button.dart';

class RequestFeature extends StatefulWidget {
  @override
  _RequestFeatureState createState() => _RequestFeatureState();
}

class _RequestFeatureState extends State<RequestFeature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          childs: [],
          onTapBack: () {
            Get.back();
          }),
      body: GetBuilder<RequestFeatureController>(
        init: RequestFeatureController(),
        builder: (_) {
          return ObxValue(
              (isAuth) => Container(
                    height: Get.height,
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          EvaIcons.bulb,
                          size: 40,
                          color: Colors.yellow[600],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Tell me if you have some ideas for my app.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Flexible(
                          child: TextField(
                            controller: _.requestContrl,
                            maxLines: 4,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (String value) {
                              _.onChange(value);
                            },
                            decoration: InputDecoration(
                                hintMaxLines: 5,
                                hintText: "🚀 Your idea",
                                alignLabelWithHint: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                fillColor: Colors.grey.withOpacity(0.2),
                                filled: true,
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey[400])),
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
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: isAuth.value
                              ? Container()
                              : RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontFamily: AppFonts.gSansItalic,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: "You must",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {}),
                                      TextSpan(
                                          text: " login",
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              BotToast.showText(
                                                  text: "On working feature");
                                            }),
                                      TextSpan(
                                        text: " to submit",
                                      )
                                    ],
                                  ),
                                ),
                        ),
                        Spacer(),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ObxValue(
                                (submitValue) => CustomButton(
                                      onPress: () {
                                        _.submit();
                                      },
                                      iconColor: Colors.indigo[900],
                                      height: 50,
                                      width: Get.width,
                                      backgroundColor: Colors.indigo,
                                      tooltip: "Submit",
                                      isClickable:
                                          (submitValue.value && isAuth.value),
                                      childs: [
                                        Text(
                                          "Submit",
                                          style: AppStyle.signInButtonText,
                                        )
                                      ],
                                    ),
                                _.hasValue),
                          ),
                        )
                      ],
                    ),
                  ),
              _.isAuthentication);
        },
      ),
    );
  }
}
