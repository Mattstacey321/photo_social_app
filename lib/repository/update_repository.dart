import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_social/api/query.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/models/appVersionModel.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:path_provider/path_provider.dart';

import 'base_repository.dart';

class UpdateRepository {
  static AppVersionModel _appUpdateInfo;

  static Future<String> getAppVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    //String appName = packageInfo.appName;
    //String packageName = packageInfo.packageName;
    //String buildNumber = packageInfo.buildNumber;
    return packageInfo.version;
  }

  static Future<bool> compareVersion(String latestVersion) async {
    var result = Version.prioritize(
        Version.parse(latestVersion), Version.parse(await getAppVersion()));
    if (result == 0) return false;
    if (result == -1) return false;
    return true;
  }

  static Future<AppVersionModel> getUpdateFromServer() async {
    var result = await BaseRepository.pubClient.checkLatest();
    return _appUpdateInfo = AppVersionModel.fromMap(result.data['checkLatest']);
  }

  static Future downloadUpdate() async {
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
      fileName: _appUpdateInfo.fileName,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  static Future<String> _findLocalPath() async {
    if (await Permission.storage.request() == PermissionStatus.granted) {
      final directory = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      return directory.path;
    } else {
      return "";
    }
  }

  static Future<bool> skipUpdate() async {
    await PreferencesController.getPrefs.setBool('installLater', true);
    return true;
  }
}
