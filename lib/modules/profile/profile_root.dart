import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/utils/nested_key.dart';
import 'navigator/advanced_setting.dart';
import 'navigator/profile.dart';

class ProfileRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "/profile",
      key: Get.nestedKey(NestedKey.profile),
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        return true;
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/profile") {
          return GetPageRoute(
            routeName: "profile",
            page: () => ProfileView(),
          );
        }
        if (settings.name == "/advanced-setting")
          return GetPageRoute(
            routeName: "advanced-setting",
            page: () => AdvancedSetting(),
          );
        throw Exception('Invalid route: ${settings.name}');
      },
    );
  }
}
