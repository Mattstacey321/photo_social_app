import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/preferences_controller.dart';
import 'package:photo_social/services/config_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  runApp(MyApp(home: StartUpScreen()));
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  final Widget home;
  MyApp({this.home});
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      hideFooterWhenNotFull: true,
      child: GetMaterialApp(
        title: 'Photo Social',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        themeMode: PreferencesController.themeMode,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        initialRoute: '/',
        getPages: AppPages.routes,
        initialBinding: BaseController(),
        transitionDuration: Duration(milliseconds: 500),
        home: home,
      ),
    );
  }
}
