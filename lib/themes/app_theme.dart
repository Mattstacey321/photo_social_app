import 'package:flutter/material.dart';
import 'package:photo_social/themes/app_colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'GoogleSans-Regular',
    brightness: Brightness.light,
    backgroundColor: AppColors.white,
  );
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'GoogleSans-Regular',
    backgroundColor: AppColors.darkGreyBG,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkGreyBG,
  );
}
