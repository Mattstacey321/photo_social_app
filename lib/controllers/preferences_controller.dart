import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesController extends GetxController {
  static SharedPreferences refs;

  static Future load() async {
    refs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get getPrefs => refs;
}
