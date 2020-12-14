import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_social/modules/theme/theme_controller.dart';

class LoadingIndicator {
  static SpinKitThreeBounce get defaultCheckingUpdateLoading =>
      SpinKitThreeBounce(
        size: 20,
        color: ThemeController.to.loadingIndicatorColor,
      );
  static SpinKitFadingCube defaultLoading(
          {Color color = Colors.black, double size = 25}) =>
      SpinKitFadingCube(
        color: ThemeController.to.loadingIndicatorColor,
        size: size,
      );
  static SpinKitThreeBounce footerLoading(
          {Color color = Colors.black, double size = 25}) =>
      SpinKitThreeBounce(
        color: ThemeController.to.loadingIndicatorColor,
        size: size,
      );
  static SpinKitRing listLoading(
          {Color color = Colors.black, double size = 25}) =>
      SpinKitRing(
        color: ThemeController.to.loadingIndicatorColor,
        size: size,
        lineWidth: 2,
      );
  static SpinKitWave startUpLoading(
          {Color color = Colors.black, double size = 25}) =>
      SpinKitWave(
        color: ThemeController.to.loadingIndicatorColor,
        size: size,
      );
}
