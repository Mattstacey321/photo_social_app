import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/constraint.dart';
import 'package:photo_social/models/user_model.dart';
import 'package:photo_social/modules/local_authentication/local_authentication_controller.dart';
import 'package:photo_social/modules/theme/theme_controller.dart';

class AccountController extends GetxController {
  static AccountController get to => Get.find();
  final UserModel _user;
  AccountController({UserModel user}) : _user = user;
  LocalAuthentication _authentication = LocalAuthentication();

  bool get hasSession => !_user.isNull;
  String get userName => _user.name ?? "Guest";
  String get avatar => _user.avatar ?? AppConstraints.defaultAvatar;
  UserModel get getUser => _user;
  bool get isGuest => _user.guest;

  void switchTheme(bool value) {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    ThemeController.to.switchTheme(value);
  }

  void signOut() {
    _authentication.clearSession();
    Get.offNamedUntil('/login', (route) => false);
  }
}
