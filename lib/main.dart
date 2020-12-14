import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_social/services/config_services.dart';
import 'package:photo_social/translattions/app_translations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'modules/theme/theme_controller.dart';
import 'modules/base/base_binding.dart';
import 'modules/start_up/startup_screen.dart';
import 'routes/app_routes.dart';
import 'themes/app_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(MyApp(home: StartUpScreen()));
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  final Widget home;
  MyApp({this.home});
  @override
  Widget build(BuildContext context) {
    // disable glow effect to all listview, gridview
    return NotificationListener(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowGlow();
        return false;
      },
      child: WillPopScope(
        onWillPop: () => handleDoubleTap(context),
        child: RefreshConfiguration(
          hideFooterWhenNotFull: true,
          child: GetMaterialApp(
            title: 'Photo Social',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeController.to.themeMode,
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            initialBinding: BaseBinding(),
            transitionDuration: Duration(milliseconds: 350),
            translationsKeys: AppTranslation.translations,
            home: home,
          ),
        ),
      ),
    );
  }
}

Future<bool> handleDoubleTap(BuildContext context) async {
  int backPressCounter = 0;
  int backPressTotal = 2;
  if (backPressCounter < 2) {
    BotToast.showText(
        text: "Press ${backPressTotal - backPressCounter} time to exit app");
    backPressCounter++;
    Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
      backPressCounter--;
    });
    return Future.value(false);
  } else {
    return Future.value(true);
  }
}
