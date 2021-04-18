import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/utils/nested_key.dart';
import '../../base/controllers/base_controller.dart';
import '../../forum_detail/views/forum_detail.dart';
import '../views/forum_view.dart';

class HomeRouteObserver extends NavigatorObserver {
  final _controller = BaseController.to;
  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    switch (screenName) {
      case "home":
        _controller.setStackPage("home", "/", NestedKey.home);
        break;
      case "forum-detail":
        _controller.setStackPage("home", "/forum-detail", NestedKey.home);
        break;
      default:
        null;
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute == null) {
    } else
      _sendScreenView(route);
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}

class HomeDesktop extends GetView<BaseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: Get.height,
          width: Get.width,
          child: Navigator(
            key: Get.nestedKey(NestedKey.home),
            initialRoute: "/",
            observers: [HomeRouteObserver()],
            onGenerateRoute: (settings) {
              if (settings.name == "/") {
                return GetPageRoute(
                  routeName: "/",
                  settings: RouteSettings(name: "home"),
                  page: () => ForumView(),
                );
              }
              if (settings.name == "/forum-detail") {
                return GetPageRoute(
                    routeName: "forum-detail",
                    settings: RouteSettings(name: "forum-detail"),
                    page: () => ForumDetailView(forumInfo: settings.arguments));
              } else
                throw Exception('Invalid route: ${settings.name}');
            },
          )),
    );
  }
}