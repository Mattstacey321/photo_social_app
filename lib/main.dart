import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'data/services/config_services.dart';
import 'data/themes/app_theme.dart';
import 'data/translattions/app_translations.dart';
import 'global_widgets/index.dart';
import 'modules/base/bindings/base_binding.dart';
import 'modules/theme/theme_controller.dart';
import 'routes/app_routes.dart';
import 'routes/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // disable glow effect to all listview, gridview
    //final _beamsLocation = [BaseLocation()];
    return NotificationListener(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowGlow();
        return false;
      },
      child: WillPopScope(
        onWillPop: () => handleDoubleTap(context),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: RefreshConfiguration(
            hideFooterWhenNotFull: true,
            footerBuilder: () => SRLoadingState.loadMore,
            child: GetMaterialApp(
              /*routeInformationParser: BeamerRouteInformationParser(),
              routerDelegate: RootRouterDelegate(
                navigatorObservers: [
                  BotToastNavigatorObserver(),
                ],
                beamLocations: _beamsLocation,
              ),*/
              title: 'Photo Social',
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              debugShowCheckedModeBanner: false,
              themeMode: ThemeController.to.themeMode,
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              initialRoute: Routes.STARTUP,
              getPages: AppPages.routes,
              initialBinding: BaseBindings(),
              transitionDuration: Duration(milliseconds: 350),
              translationsKeys: AppTranslation.translations,
            ),
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
    BotToast.showText(text: "Press ${backPressTotal - backPressCounter} time to exit app");
    backPressCounter++;
    Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
      backPressCounter--;
    });
    return Future.value(false);
  } else {
    return Future.value(true);
  }
}
