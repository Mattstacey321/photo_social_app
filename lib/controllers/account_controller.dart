import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/constraint.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/repository/update_repository.dart';

class AccountController extends GetxController {
  RxString currentVersion = "".obs;
  var _latestVersion = "".obs;
  Rx<bool> checkingUpdate = Rx<bool>();
  RxBool isDarkMode = false.obs;

  @override
  void onReady() {
    getCurrenAppVersion();
    getAppTheme();
  }

  //String get currentVersion => _currentVersion.value;
  String get latestVersion => _latestVersion.value;

  void getCurrenAppVersion() async {
    currentVersion.value = await UpdateRepository.getAppVersion();
  }

  void getAppTheme() async {
    isDarkMode.value = await ThemeController.to.getThemeModeFromPreferences();
    print("dark mode : ${isDarkMode.value}");
  }

  String getAvatar() {
    bool isSkipLogin = PreferencesController.getPrefs.getBool('isSkipLogin');
    return isSkipLogin
        ? AppConstraint.defaultAvatar
        : PreferencesController.getPrefs.getString("userAvatar");
  }

  String getName() {
    bool isSkipLogin = PreferencesController.getPrefs.getBool('isSkipLogin');
    return isSkipLogin
        ? "Guest"
        : PreferencesController.getPrefs.getString("userName");
  }

  checkUpdate(c) async {
    try {
      var updateResult = await UpdateRepository.getUpdateFromServer()
          .timeout(Duration(seconds: 10));
      _latestVersion.value = updateResult.version;
      checkingUpdate.value =
          await UpdateRepository.compareVersion(updateResult.version);
      return checkingUpdate.value ? c() : null;
    } on TimeoutException {} catch (err) {
      c();
    }
  }

  void switchTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    ThemeController.to.updateThemeModeToPreferences(value: isDarkMode.value);
  }
}
