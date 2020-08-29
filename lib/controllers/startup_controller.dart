import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_social/api/query.dart';
import 'package:photo_social/models/AppVersionModel.dart';
import 'package:photo_social/repository/base_repository.dart';
import 'package:photo_social/screens/start_up/widgets/update_dialog.dart';
import 'package:photo_social/utils/check_token.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show Directory, Platform;

class StartUpController extends GetxController {
  static StartUpController get to => Get.find();
  var _waitGetLatest = Rx<QueryResult>();
  var _isNeedUpdate = false.obs;
  var _downloadPath = "".obs;
  Rx<AppVersionModel> _updateResult = Rx<AppVersionModel>();

  @override
  void onStart() {
    getAndCheckAppVersion();
    ever(_isNeedUpdate, (result) {
      return result
          ? Future.delayed(Duration(seconds: 1), () => showUpdateDialog())
          : goToDestinationPage();
    });
  }

  QueryResult get waitGetLatest => _waitGetLatest.value;
  bool get isNeedUpdate => _isNeedUpdate.value;
  AppVersionModel get updateResult => _updateResult.value;

  void getAndCheckAppVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    //String appName = packageInfo.appName;
    //String packageName = packageInfo.packageName;
    //String buildNumber = packageInfo.buildNumber;

    String currentVersion = packageInfo.version;

    _waitGetLatest.value = await BaseRepository.pubClient.checkLatest();
    _updateResult.value =
        AppVersionModel.fromMap(waitGetLatest.data['checkLatest']);

    checkUpdate(currentVersion);
  }

  void checkUpdate(String currentVersion) {
    bool isNeedUpdate = Version.prioritize(Version.parse(updateResult.version),
                Version.parse(currentVersion)) ==
            1
        ? true
        : false;
    _isNeedUpdate.value = isNeedUpdate;
  }

  void showUpdateDialog() async {
    await Get.dialog(UpdateDialog(), barrierDismissible: false);
  }

  void goToDestinationPage() async {
    await Get.offAllNamed(await isAuth() ? '/' : '/home');
  }

  Future downloadUpdate() async {
    if (_downloadPath == null) {}
    var _localPath =
        (await _findLocalPath()) + Platform.pathSeparator + 'Download';
    var savedDir = Directory(_localPath);
    bool hasDirectoryExisted = await savedDir.exists();
    if (!hasDirectoryExisted) {
      savedDir.create();
    }

    await FlutterDownloader.enqueue(
      url: updateResult.donwloadUrl,
      savedDir: _localPath,
      fileName: updateResult.fileName,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  Future<String> _findLocalPath() async {
    if (await Permission.storage.request() == PermissionStatus.granted) {
      final directory = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      return directory.path;
    } else {
      return "";
    }
  }

  Future<bool> skipUpdate() async {
    goToDestinationPage();
    return true;
  }
}
