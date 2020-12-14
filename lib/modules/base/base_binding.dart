import 'package:get/get.dart';
import 'package:photo_social/constraint/app_controllers.dart';
import 'package:photo_social/modules/local_authentication/local_authentication_controller.dart';

class BaseBinding extends Bindings {
  LocalAuthentication _localAuthentication = LocalAuthentication();
  @override
  void dependencies() {
    Get.putAsync(() async {
      final userInfo = await _localAuthentication.getUserInfo();
      return AccountController(user: userInfo);
    });
    Get.lazyPut(() => ForumController());
    Get.lazyPut(() => HomeController());
    Get.put<HashTagController>(HashTagController(), permanent: true);
    Get.put(BookmarkController(), permanent: true);
    Get.put(CollectionController(), permanent: true);
    Get.put(UpdateController(), permanent: true);
  }
}
