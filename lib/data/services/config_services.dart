import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../modules/authentication/controllers/local_authentication_controller.dart';
import '../../modules/theme/theme_controller.dart';
import '../api/graphql.dart';

Future initServices() async {
  //await Get.putAsync(() => ConfigServices().initializeDownloader());
  await Get.putAsync(() => ConfigServices().initializeTimeAgo());
  await Get.putAsync(() => ConfigServices().initializeHive());
  await Get.putAsync(() => ConfigServices().initializeGraphQLCache());
  await Get.putAsync(() => ConfigServices().initializeSetting());
}

class ConfigServices extends GetxService {
  Future initializeSetting() async {
    Get.lazyPut(() => GetStorage());
    await Get.putAsync<LocalAuthentication>(() async {
      final _authentication = LocalAuthentication();
      await _authentication.initSession();
      final user = await _authentication.getUserInfo();
      Get.put(GraphQL(isGuest: user.guest, token: user.token));
      return _authentication;
    });
  }

  Future initializeGraphQLCache() async {
    if (GetPlatform.isMobile) {
      await initHiveForFlutter();
    } else {
      final directory = await getApplicationSupportDirectory();
      await initHiveForFlutter(subDir: directory.path);
    }
    return this;
  }

  Future initializeDownloader() async => await FlutterDownloader.initialize(debug: true);

  //set timeago locate
  Future initializeTimeAgo() async {
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    timeago.setLocaleMessages('vi_short', timeago.ViShortMessages());
    return this;
  }

  Future initializeHive() async {
    await GetStorage.init("themeBox");
    final box = GetStorage("themeBox");
    //final box = await Hive.openBox("themeBox");
    var _currentTheme = box.read("currentTheme");
    if (_currentTheme == null) {
      await box.write("currentTheme", false);
    }
    Get.put(ThemeController(
        themeBox: box, currentTheme: _currentTheme == null ? false : _currentTheme));
    return this;
  }
}
