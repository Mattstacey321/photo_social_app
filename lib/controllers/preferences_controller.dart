import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesController extends GetxController {
  static SharedPreferences refs;

  static Future load() async {
    refs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get getPrefs => refs;

  static bool get isDarkMode {
    return PreferencesController.getPrefs.getBool("darkMode") ?? false;
  }

  static Color get colorTheme {
    return !PreferencesController.isDarkMode
        ? ColorStyle.darkGreyBG
        : Colors.white;
  }
}
