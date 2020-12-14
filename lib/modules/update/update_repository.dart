import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_social/api/extension/index.dart';
import 'package:photo_social/api/graphql.dart';
import 'package:photo_social/api/schema/schema.dart';
import 'package:photo_social/models/app_version_model.dart';
import 'package:pub_semver/pub_semver.dart';

class UpdateRepository {
  GraphQLClient _pubClient = Get.find<GraphQL>().pubClient;
  AppVersionModel _appUpdateInfo;

  Future<String> getAppVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    //String appName = packageInfo.appName;
    //String packageName = packageInfo.packageName;
    //String buildNumber = packageInfo.buildNumber;
    return packageInfo.version;
  }

  Future<bool> compareVersion(String latestVersion) async {
    var result = Version.prioritize(
        Version.parse(latestVersion), Version.parse(await getAppVersion()));
    if (result == 0) return false;
    if (result == -1) return false;
    return true;
  }

  Future<AppVersionModel> getUpdateFromServer() async {
    var result = await _pubClient.checkLatest();
    return _appUpdateInfo =
        AppVersionModel.fromMap(result.data[GqlSchema.checkLatest.name]);
  }

  Future downloadUpdate() async {
    await getUpdateFromServer();
    var _localPath =
        (await _findLocalPath()) + Platform.pathSeparator + 'Download';
    var savedDir = Directory(_localPath);
    bool hasDirectoryExisted = await savedDir.exists();
    if (!hasDirectoryExisted) {
      savedDir.create();
    }

    await FlutterDownloader.enqueue(
      url: _appUpdateInfo.donwloadUrl,
      savedDir: _localPath,
      fileName: "${_appUpdateInfo.fileName}.apk",
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

  /*static Future<bool> skipUpdate() async {
    await PreferencesController.getPrefs.setBool('installLater', true);
    return true;
  }*/
}
