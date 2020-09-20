import 'package:flutter/material.dart';
import 'package:photo_social/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'GoogleSans-Regular',
    brightness: Brightness.light,
    backgroundColor: ColorStyle.white,
  );
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'GoogleSans-Regular',
    backgroundColor: ColorStyle.darkGreyBG,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorStyle.darkGreyBG,
  );
}
