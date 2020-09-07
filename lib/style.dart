import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppStyle {
  static TextStyle appBarTitle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle bannerTitle =
      TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white);
  static TextStyle bannerNumber = TextStyle(fontSize: 16, color: Colors.white);
  static TextStyle wellcomeTextLogin =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static TextStyle signInButtonText =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white);
  static SpinKitDoubleBounce defaultLoading(
          {Color color = Colors.black, double size = 25}) =>
      SpinKitDoubleBounce(
        color: color,
        size: size,
      );
}
