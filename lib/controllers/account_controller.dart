import 'dart:async';

import 'package:get/get.dart';
import 'package:photo_social/constraint.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/repository/update_repository.dart';

class AccountController extends GetxController {
  RxString currentVersion = "".obs;
  var _latestVersion = "".obs;
  Rx<bool> checkingUpdate = Rx<bool>();

  @override
  void onReady() {
    getCurrenAppVersion();
  }

  //String get currentVersion => _currentVersion.value;
  String get latestVersion => _latestVersion.value;

  void getCurrenAppVersion() async {
    currentVersion.value = await UpdateRepository.getAppVersion();
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
}
