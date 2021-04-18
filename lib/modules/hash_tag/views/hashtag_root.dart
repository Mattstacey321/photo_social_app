import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/utils/nested_key.dart';
import '../navigator/hashtag_dashboard.dart';
import '../navigator/hashtag_detail.dart';

class HashTagRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "/",
      key: Get.nestedKey(NestedKey.hashTag),
      onPopPage: (route, result) {
        print(route);
        if (!route.didPop(result)) return false;
        return true;
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        if (settings.name == "/") {
          return GetPageRoute(page: () => HashTagDashboard());
        } else if (settings.name == "/detail")
          return GetPageRoute(
            page: () => HashTagDetail(hashTag: settings.arguments),
          );
        throw Exception('Invalid route: ${settings.name}');
      },
    );
  }
}
