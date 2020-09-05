import 'dart:async';

import 'package:get/get.dart';
import 'package:photo_social/api/query.dart';
import 'package:photo_social/repository/base_repository.dart';
import 'package:photo_social/screens/start_up/widgets/update_dialog.dart';
import 'package:photo_social/utils/check_token.dart';
import 'package:photo_social/utils/server_status.dart';

class StartUpController extends GetxController {
  static StartUpController get to => Get.find();
  var _isServerOnline = ServerStatus.checking.obs;

  @override
  void onInit() {
    checkServer();
    test();
  }

  void test() {
    ever(_isServerOnline, (result) {
      if (result == ServerStatus.checking) {
        checkServer();
      }
      if (result == ServerStatus.online) {
        Future.delayed(Duration(seconds: 1), () => goToDestinationPage());
      }
    });
  }

  String get isServerOnline => _isServerOnline.value;

  void checkAgain() {
    if (_isServerOnline.value == ServerStatus.offline) {
      _isServerOnline.value = ServerStatus.checking;
    }
  }

  void checkServer() async {
    try {
      var statusResult = await BaseRepository.pubClient
          .checkServerStatus()
          .timeout(Duration(seconds: 15));
      _isServerOnline.value = statusResult.data['status']
          ? ServerStatus.online
          : ServerStatus.offline;
    } on TimeoutException catch (_) {
      _isServerOnline.value = ServerStatus.offline;
    }
  }

  void showUpdateDialog() async {
    await Get.dialog(UpdateDialog(), barrierDismissible: false);
  }

  void goToDestinationPage() async {
    await Get.offAllNamed(await isAuth() ? '/login' : '/home');
  }
}
