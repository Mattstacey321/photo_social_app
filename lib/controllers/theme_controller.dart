import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();
  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  updateThemeModeToPreferences({@required bool value}) async {
    PreferencesController.getPrefs.setBool("darkMode", value);
  }

  Future<bool> getThemeModeFromPreferences() async {
    return PreferencesController.getPrefs.getBool("darkMode") ?? false;
  }

  updateDefaultLanguageToPrefrences({String locate}) async {
    return await PreferencesController.getPrefs.setString("language", locate);
  }

  Future<String> getLanguageFromPreferences() async {
    return PreferencesController.getPrefs.getString("language");
  }
}
