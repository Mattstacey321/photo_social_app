import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constraint.dart';
import '../../../data/models/user_model.dart';
import '../../../data/themes/index.dart';
import '../../../global_widgets/index.dart';
import '../../authentication/controllers/local_authentication_controller.dart';
import '../../theme/theme_controller.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  // final UserModel _user;
  // ProfileController({UserModel user}) : _user = user;
  LocalAuthentication _authentication;
  ProfileController({@required LocalAuthentication localAuth}) : _authentication = localAuth;
  var user = Rxn<UserModel>();

  bool get hasSession => user != null;
  String get userName => user.value.name ?? "Guest";
  String get avatar => user.value.avatar ?? AppConstraints.defaultAvatar;
  UserModel get getUser => user.value;
  bool get isGuest => user.value.guest ?? false;

  void switchTheme(bool value) {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    ThemeController.to.switchTheme(value);
  }

  void getUserInfo() async {
    user.value = await _authentication.getUserInfo();
  }

  void signOut() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        insetPadding: EdgeInsets.all(0),
        child: Container(
          height: 150,
          width: Get.width - 100,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Log out ?",
                style: TextStyle(fontSize: AppSizes.dialogTitle),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                      onPress: () {
                        Get.back();
                      },
                      tooltip: "Cancel",
                      iconColor: Colors.indigo,
                      opacity: 1,
                      childs: [Text("Cancel")]),
                  SizedBox(width: 5),
                  CustomButton(
                    onPress: () {
                      _authentication.clearSession();
                      Get.offNamedUntil('/login', (route) => false);
                    },
                    tooltip: "Log out",
                    iconColor: Colors.red,
                    opacity: 1,
                    childs: [Text("Log out")],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }
}
