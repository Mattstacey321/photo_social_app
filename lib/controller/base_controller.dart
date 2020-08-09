import 'package:get/get.dart';
import 'package:photo_social/controller/home_controller.dart';

class BaseController extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    
  }
}
