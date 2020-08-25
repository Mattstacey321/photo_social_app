import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:photo_social/api/query.dart';
import 'package:photo_social/models/AppVersionModel.dart';
import 'package:photo_social/ui/home/home.dart';
import 'package:photo_social/ui/login/login.dart';
import 'package:photo_social/ui/start_up/widgets/update_dialog.dart';
import 'package:photo_social/utils/check_token.dart';
import 'package:photo_social/repository/base_repository.dart';
import 'package:pub_semver/pub_semver.dart';

class StartUpController extends GetxController {
  static StartUpController get to => Get.find();
  var _waitGetLatest = Rx<QueryResult>();
  var _isNeedUpdate = false.obs;
  @override
  void onStart() {
    checkAppVersion();
    ever(_isNeedUpdate, (result) {
      return result
          ? Future.delayed(Duration(seconds: 1), () => updateDialog())
          : goToDestinationPage();
    });
  }

  QueryResult get waitGetLatest => _waitGetLatest.value;
  bool get isNeedUpdate => _isNeedUpdate.value;

  void checkAppVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    //print("$appName,$packageName,$version,$buildNumber}");
    _waitGetLatest.value =
        await BaseRepository.pubClient.checkLatest(currentVersion: version) ?? null;
    var result = AppVersionModel.fromMap(waitGetLatest.data['checkLatest']);
    bool isNeedUpdate =
        Version.prioritize(Version.parse(result.version), Version.parse(version)) == 1
            ? true
            : false;
    _isNeedUpdate.value = isNeedUpdate;
  }

  Future updateDialog() {
    return Get.dialog(UpdateDialog());
  }

  void goToDestinationPage() async {
    Get.off(await isAuth() ? Login() : Home());
  }
}