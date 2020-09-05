import 'package:bot_toast/bot_toast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/account_controller.dart';
import 'package:photo_social/screens/profile/widgets/custom_setting.dart';
import 'package:photo_social/screens/start_up/widgets/update_dialog.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/widgets/custom_appBar.dart';
import 'package:photo_social/widgets/custom_avatar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
        init: AccountController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Color(0xffE5EAF6),
            appBar: CustomAppBar(
                color: Color(0xffE5EAF6).withOpacity(0.7),
                childs: [
                  Text(
                    "Profile",
                    style: AppStyle.appBarTitle,
                  )
                ],
                height: 50,
                onTapBack: () {
                  Get.back();
                }),
            body: Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  Container(
                    height: 250,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Color(0xffE5EAF6).withOpacity(0.7),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomAvatar(
                          url: _.getAvatar(),
                          onTap: () {},
                          size: 120,
                          enableElevation: true,
                          toolTip: "Your avatar",
                          borderRadius: 1000,
                        ),
                        SizedBox(height: 20),
                        Text(
                          _.getName(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                CustomSetting(
                                  iconColor: Colors.orange,
                                  iconSize: 40,
                                  icon: EvaIcons.arrowCircleDown,
                                  onTap: () async {
                                    CancelFunc cancelFunc =
                                        BotToast.showCustomLoading(
                                            onClose: () {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                      (timeStamp) {
                                                _.checkingUpdate.value
                                                    ? Get.dialog(UpdateDialog(
                                                        isNeedUpdate: true,
                                                      ))
                                                    : Get.dialog(UpdateDialog(
                                                        isNeedUpdate: false,
                                                      ));
                                              });
                                            },
                                            toastBuilder: (builder) {
                                              return Container(
                                                height: 100,
                                                width: 250,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SpinKitThreeBounce(
                                                        size: 20,
                                                        color: Colors.black),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Checking update ...")
                                                  ],
                                                ),
                                              );
                                            },
                                            allowClick: true,
                                            crossPage: false,
                                            clickClose: true);
                                    _.checkUpdate(cancelFunc);
                                  },
                                  title: "Check update",
                                ),
                                CustomSetting(
                                  iconColor: Colors.blue,
                                  iconSize: 40,
                                  icon: EvaIcons.globe3,
                                  onTap: () {},
                                  title: "Language",
                                  widget: Text("English"),
                                ),
                                CustomSetting(
                                  iconColor: Colors.black,
                                  iconSize: 40,
                                  icon: EvaIcons.colorPalette,
                                  onTap: () {},
                                  title: "Theme",
                                  widget: Text("Light"),
                                ),
                                ObxValue<RxInterface>(
                                    (data) => CustomSetting(
                                          iconColor: Colors.purple,
                                          iconSize: 40,
                                          icon: EvaIcons.info,
                                          onTap: () {},
                                          title: "About",
                                          widget: Text(data.value),
                                        ),
                                    _.currentVersion),
                                Spacer(),
                                Divider(),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CustomSetting(
                                    iconSize: 40,
                                    iconColor: Colors.red,
                                    icon: EvaIcons.logOut,
                                    onTap: () {},
                                    title: "Log out",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
