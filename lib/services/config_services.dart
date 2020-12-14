import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_social/api/graphql.dart';
import 'package:photo_social/modules/local_authentication/local_authentication_controller.dart';
import 'package:photo_social/modules/theme/theme_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

Future initServices() async {
  await Get.putAsync(() => ConfigServices().initializeDownloader());
  await Get.putAsync(() => ConfigServices().initializeTimeAgo());
  await Get.putAsync(() => ConfigServices().initializeHive());
  await Get.putAsync(() => ConfigServices().initializeGraphqlCache());
  await Get.putAsync(() => ConfigServices().initializeSetting());
}

class ConfigServices extends GetxService {
  Future initializeSetting() async {
    Get.lazyPut(() => FlutterSecureStorage());

    await Get.putAsync<LocalAuthentication>(() async {
      final LocalAuthentication _authentication = LocalAuthentication();
      await _authentication.initSession();
      final user = await _authentication.getUserInfo();
      Get.lazyPut<GraphQL>(
          () => GraphQL(isGuest: user.guest, token: user.token),
          fenix: true);
      return _authentication;
    });
  }

  Future initializeGraphqlCache() async => await initHiveForFlutter();

  Future initializeDownloader() async =>
      await FlutterDownloader.initialize(debug: true);

  //set timeago locate
  Future initializeTimeAgo() async {
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    timeago.setLocaleMessages('vi_short', timeago.ViShortMessages());
  }

  Future initializeHive() async {
    await Hive.initFlutter();
    Box box = await Hive.openBox("themeBox");
    var _currentTheme = box.get("currentTheme");
    if (_currentTheme == null) {
      box.put("currentTheme", false);
    }
    Get.put<ThemeController>(ThemeController(
        themeBox: box,
        currentTheme: _currentTheme == null ? false : _currentTheme));
  }
}
