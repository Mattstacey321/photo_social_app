import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/utils/nested_key.dart';

import 'navigator/advanced_setting.dart';
import 'navigator/profile_options.dart';

class ProfileRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "/",
      key: Get.nestedKey(NestedKey.profile),
      pages: [
        MaterialPage(child: Profile()),
        MaterialPage(child: AdvancedSetting()),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        return true;
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return GetPageRoute(page: () => Profile());
        } else if (settings.name == "/advanced-setting")
          return GetPageRoute(page: () => AdvancedSetting());
        throw Exception('Invalid route: ${settings.name}');
      },
    );
  }
}
