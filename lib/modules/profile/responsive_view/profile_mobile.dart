import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/themes/index.dart';
import '../../../data/utils/nested_key.dart';
import '../../../global_widgets/index.dart';
import '../../theme/theme_controller.dart';
import '../controllers/profile_controller.dart';
import '../widgets/setting_item.dart';

class ProfileMobile extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        //color: Color(0xffE5EAF6).withOpacity(0.7),
        childs: [
          Text(
            "Profile",
            style: AppStyles.appBarTitle,
          )
        ],
        height: 50,
        onTapBack: () {
          //go to home page
          //TODO: change profile page
          //BaseController.to.changePage(0);
        },
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Container(
              height: Get.height / 3,
              width: Get.width,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomAvatar(
                    url: controller.avatar,
                    onTap: () {},
                    size: 120,
                    enableElevation: true,
                    toolTip: "Your avatar",
                    borderRadius: 1000,
                  ),
                  SizedBox(height: 20),
                  Text(
                    controller.userName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ObxValue(
              (isDarkMode) {
                return Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: isDarkMode.value ? AppColors.darkGrey900 : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, -2)),
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              /*SettingItem(
                                  icon: EvaIcons.paperPlane,
                                  title: "Request Feature",
                                  iconColor: Colors.red,
                                  iconSize: 40,
                                  onTap: () {
                                    Get.to(RequestFeature());
                                  },
                                ),*/
                              SettingItem(
                                iconColor: Colors.blue,
                                iconSize: 40,
                                icon: EvaIcons.globe3,
                                onTap: () {},
                                title: "Language",
                                widget: Text("English"),
                              ),
                              SettingItem(
                                iconColor: Colors.cyan,
                                iconSize: 40,
                                icon: EvaIcons.colorPalette,
                                onTap: null,
                                title: "Theme",
                                addPadding: false,
                                widget: ThemeSwitcher(
                                  value: !isDarkMode.value,
                                  onTap: () {
                                    controller.switchTheme(!isDarkMode.value);
                                  },
                                ),
                              ),
                              SettingItem(
                                iconColor: Colors.lime,
                                iconSize: 40,
                                icon: EvaIcons.settings2,
                                onTap: () {
                                  Get.toNamed("/advanced-setting", id: NestedKey.profile);
                                },
                                title: "Advanced Setting",
                                addPadding: false,
                              ),
                              /*ObxValue(
                                  (data) => SettingItem(
                                    iconColor: Colors.purple,
                                    iconSize: 40,
                                    icon: EvaIcons.info,
                                    onTap: () {},
                                    title: "About",
                                    widget: Text(data.value),
                                  ),
                                  UpdateController.to.currentVersion,
                                ),*/
                              Spacer(),
                              Divider(),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SettingItem(
                                  iconSize: 40,
                                  iconColor: Colors.red,
                                  icon: EvaIcons.logOut,
                                  onTap: () {
                                    controller.signOut();
                                  },
                                  title: "Log out",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              ThemeController.to.isDarkMode,
            )
          ],
        ),
      ),
    );
  }
}