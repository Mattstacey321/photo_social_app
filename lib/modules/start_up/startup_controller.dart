import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/routes/routes.dart';

import '../../data/repositories/start_up_repository.dart';
import '../../data/utils/check_token.dart';
import '../../src/enum/index.dart';

class StartUpController extends GetxController {
  static StartUpController get to => Get.find();
  final StartUpRepository _startupRepository;
  StartUpController({@required StartUpRepository startUpRepository})
      : _startupRepository = startUpRepository;
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
          .then((value) => setServerStatus(value));
    } on TimeoutException catch (_) {
      isServerOnline(ServerStatus.offline);
    }
  }

  void setServerStatus(bool isRunning) {
    isServerOnline(isRunning ? ServerStatus.online : ServerStatus.offline);
  }

  void goToDestinationPage() async {
    await Get.offAllNamed(await isAuth() ? Routes.HOME : Routes.LOGIN);
  }
}
