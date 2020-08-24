import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:photo_social/ui/home/home.dart';
import 'package:photo_social/ui/login/login.dart';
import 'package:photo_social/utils/check_token.dart';

class StartUpController extends GetxController {
  @override
  void onInit() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      print("$appName,$packageName,$version,$buildNumber}");
    });
  }

  void goToDestinationPage() async {
    Get.off(await isAuth() ? Login() : Home());
  }
}
