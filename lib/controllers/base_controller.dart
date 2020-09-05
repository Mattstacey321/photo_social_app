import 'package:get/get.dart';
import 'package:photo_social/repository/base_repository.dart';
import 'controller.dart';

class BaseController extends Bindings {
  @override
  void dependencies() {
    Get.put(() => BaseRepository());
    Get.lazyPut(() => ForumController());
    Get.lazyPut(() => HomeController());
  }
}
