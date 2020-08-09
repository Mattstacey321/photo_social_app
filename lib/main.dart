import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_social/controller/base_controller.dart';
import 'package:photo_social/routes/app_routes.dart';
import 'package:photo_social/theme/theme.dart';

import 'ui/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Photo Social',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppPages.routes,
      initialBinding: BaseController(),
      transitionDuration: Duration(milliseconds: 500),
      home: Home(),
    );
  }
}
