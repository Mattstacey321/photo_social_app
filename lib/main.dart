import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_social/routes/app_routes.dart';
import 'package:photo_social/theme/theme.dart';
import 'package:photo_social/ui/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/controller.dart';
import 'ui/home/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token") ?? "";
  bool isSkipLogin = prefs.getBool("isSkipLogin") ?? false;

  runApp(MyApp(home: (token == "" && isSkipLogin == false) ? Login() : Home()));

  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  final Widget home;
  MyApp({this.home});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Photo Social',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: '/',
      getPages: AppPages.routes,
      initialBinding: BaseController(),
      transitionDuration: Duration(milliseconds: 500),
      home: home,
    );
  }
}
