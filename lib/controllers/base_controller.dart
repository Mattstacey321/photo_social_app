import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller.dart';

class BaseController extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<SharedPreferences>(() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    });
    Get.lazyPut(()=>HomeController());
  }
}
