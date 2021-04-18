import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/themes/index.dart';
class ThemeController extends GetxController {
  static ThemeController get to => Get.find();
  final GetStorage  _themeBox;
  final bool _currentTheme;
  ThemeController({@required GetStorage themeBox, bool currentTheme})
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

  void switchTheme(bool value) async{
    isDarkMode.value = value;
    await _themeBox.write("currentTheme", value);
  }

  void getCurrentTheme() async {
    isDarkMode.value = _currentTheme;
  }
}
