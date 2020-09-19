import 'package:get/get.dart';
import 'package:photo_social/config/global_config.dart';

Future initServices() async {
  await Get.putAsync(() => ConfigServices().initializeDownloader());
  await Get.putAsync(() => ConfigServices().initializeTimeAgo());
}

class ConfigServices extends GetxService {
  Future initializeDownloader() async {
    await GlobalConfig.initializeDownloader();
  }

  Future initializeTimeAgo() async {
    //set timeago locate
    await GlobalConfig.setLocate();
  }
}
