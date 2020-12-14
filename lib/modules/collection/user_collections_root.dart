import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/modules/collection/navigator/collection_detail.dart';
import 'package:photo_social/modules/collection/navigator/collections.dart';
import 'package:photo_social/utils/nested_key.dart';

class UserCollectionsRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "/",
      key: Get.nestedKey(NestedKey.collection),
      /*pages: [
        MaterialPage(child: Collections()),
        MaterialPage(child: CollectionDetail()),
     ],*/
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        return true;
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return GetPageRoute(page: () => Collections());
        } else if (settings.name == "/collection-detail")
          return GetPageRoute(
              page: () => CollectionDetail(
                    info: settings.arguments,
                  ));
        throw Exception('Invalid route: ${settings.name}');
      },
    );
  }
}
