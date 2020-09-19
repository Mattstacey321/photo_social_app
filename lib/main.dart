import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/preferences_controller.dart';
import 'package:photo_social/services/config_services.dart';

import 'config/global_config.dart';
import 'controllers/controller.dart';
import 'routes/app_routes.dart';
import 'screens/start_up/startup_screen.dart';
import 'theme/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  final PreferencesController preferencesController =
      await PreferencesController.load();
  Get.put<PreferencesController>(preferencesController, permanent: true);

  runApp(MyApp(
    home: StartUpScreen(),
    isDarkMode: PreferencesController.getPrefs.getBool('darkMode') ?? false,
  ));
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  final Widget home;
  final bool isDarkMode;
  MyApp({this.home, this.isDarkMode});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Photo Social',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.light : ThemeMode.dark,
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
