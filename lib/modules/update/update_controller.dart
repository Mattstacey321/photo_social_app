import 'dart:async';

import 'package:get/get.dart';
import 'package:photo_social/constraint/app_repositories.dart';

class UpdateController extends GetxController {
  static UpdateController get to => Get.find();
  UpdateRepository _updateRepository = UpdateRepository();
  var currentVersion = "".obs;
  var _latestVersion = "".obs;
  var checkingUpdate = false.obs;

  String get latestVersion => _latestVersion.value;

  void checkUpdate(closeDialog) async {
    try {
      var updateResult = await _updateRepository
          .getUpdateFromServer()
          .timeout(Duration(seconds: 10));
      _latestVersion.value = updateResult.version;
      checkingUpdate.value =
          await _updateRepository.compareVersion(updateResult.version);
      return checkingUpdate.value ? closeDialog() : null;
    } on TimeoutException {} catch (err) {
      closeDialog();
    }
  }

  @override
  void onReady() {
    getCurrenAppVersion();
    super.onReady();
  }

  void getCurrenAppVersion() async {
    currentVersion.value = await _updateRepository.getAppVersion();
  }
}
