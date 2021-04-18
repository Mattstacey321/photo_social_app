import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/utils/nested_key.dart';
import '../../base/controllers/base_controller.dart';
import '../navigator/collection_detail.dart';
import '../widgets/delete_collection_button.dart';
import 'collections_view.dart';

class CollectionRouteObserver extends NavigatorObserver {
  final _controller = BaseController.to;
  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    print(screenName);
    switch (screenName) {
      case "collection":
        _controller.setStackPage("collection", "/", NestedKey.collection);
        break;
      case "collection-detail":
        _controller.setStackPage("collection", "collection-detail", NestedKey.collection);
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

class CollectionsRoot extends GetView<BaseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: DeleteCollectionButton(),
      body: Navigator(
        initialRoute: "/",
        key: Get.nestedKey(NestedKey.collection),
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          return true;
        },
        observers: [CollectionRouteObserver()],
        onGenerateRoute: (settings) {
          if (settings.name == "/") {
            return GetPageRoute(
              routeName: "collection",
              settings: RouteSettings(name: "collection"),
              page: () => CollectionsView(),
            );
          }
          if (settings.name == "/collection-detail") {
            return GetPageRoute(
              routeName: "collection-detail",
              settings: RouteSettings(name: "collection-detail"),
              page: () => CollectionDetail(
                info: settings.arguments,
              ),
            );
          }
          throw Exception('Invalid route: ${settings.name}');
        },
      ),
    );
  }
}
