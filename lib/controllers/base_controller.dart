import 'package:get/get.dart';
import 'package:photo_social/repository/base_repository.dart';
import 'controller.dart';

class BaseController extends Bindings {
  @override
  void dependencies() {
    Get.put(() => BaseRepository());
    Get.put<ThemeController>(ThemeController());
    Get.lazyPut(() => ForumController());
    Get.lazyPut(() => HomeController());
  }
}
