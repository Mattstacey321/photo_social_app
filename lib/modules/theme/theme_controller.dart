import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:photo_social/themes/app_colors.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();
  final Box _themeBox;
  final bool _currentTheme;
  ThemeController({@required Box themeBox, bool currentTheme})
      : _themeBox = themeBox,
        _currentTheme = currentTheme ?? false;
  // for local state change
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentTheme();
  }

  Color get navigatorActiveColor =>
      _currentTheme ? AppColors.white : Colors.black;

  ThemeMode get themeMode => _currentTheme ? ThemeMode.dark : ThemeMode.light;

  Color get colorScheme => _currentTheme ? AppColors.darkGreyBG : Colors.white;

  Color get loadingIndicatorColor =>
      _currentTheme ? Colors.white : AppColors.darkGreyBG;

  void switchTheme(bool value) {
    isDarkMode.value = value;
    _themeBox.put("currentTheme", value);
  }

  void getCurrentTheme() async {
    isDarkMode.value = _currentTheme;
    print("Your currentTheme is ${_currentTheme ? "dark" : "light"}");
  }
}
