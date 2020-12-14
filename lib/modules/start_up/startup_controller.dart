import 'dart:async';

import 'package:get/get.dart';
import 'package:photo_social/src/dialogs/index.dart';
import 'package:photo_social/utils/check_token.dart';
import 'package:photo_social/src/enum/index.dart';

import 'start_up_repository.dart';

class StartUpController extends GetxController {
  static StartUpController get to => Get.find();
  StartUpRepository _startupRepository = StartUpRepository();
  var isServerOnline = ServerStatus.checking.obs;

  @override
  void onInit() {
    checkServer();
    test();
    super.onInit();
  }

  void test() {
    ever(isServerOnline, (result) {
      if (result == ServerStatus.checking) {
        checkServer();
      }
      if (result == ServerStatus.online) {
        Future.delayed(Duration(seconds: 1), () => goToDestinationPage());
      }
    });
  }

  void checkAgain() {
    if (isServerOnline.value == ServerStatus.offline) {
      isServerOnline(ServerStatus.checking);
    }
  }

  void checkServer() async {
    try {
      await _startupRepository
          .checkServerStatus()
          .timeout(Duration(seconds: 15))
          .then(
            (value) => setServerStatus(value),
          );
    } on TimeoutException catch (_) {
      //print(e);
      isServerOnline(ServerStatus.offline);
    }
  }

  void setServerStatus(bool isRunning) {
    isServerOnline(isRunning ? ServerStatus.online : ServerStatus.offline);
  }

  void showUpdateDialog() async {
    await Get.dialog(UpdateDialog(), barrierDismissible: false);
  }

  void goToDestinationPage() async {
    await Get.offAllNamed(await isAuth() ? '/home' : '/login');
  }
}
