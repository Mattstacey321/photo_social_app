import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/utils/nested_key.dart';
import '../../global_widgets/dialogs/base_dialog.dart';
import '../../modules/bookmark/navigator/add_collection.dart';
import '../../modules/bookmark/navigator/view_collection.dart';

Future showBookmarkDialog(BuildContext context) async {
  return baseDialog(
    height: context.height /1.5,
    width: context.width / 2,
    title: "Bookmark",
    closeWidget: ElevatedButton(onPressed: () {}, child: Text("Done")),
    confirmWidget: ElevatedButton(onPressed: () {}, child: Text("Bookmark")),
    content: [
      Flexible(
        child: Navigator(
          initialRoute: '/view',
          key: Get.nestedKey(NestedKey.addCollection),
          onPopPage: (route, result) {
            if (!route.didPop(result)) return false;
            return true;
          },
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case "/view":
                return GetPageRoute(
                  routeName: "view",
                  page: () => ViewCollection(),
                  transition: Transition.fadeIn,
                );
              case "/add":
                return GetPageRoute(
                  routeName: "add",
                  page: () => AddCollection(),
                  transition: Transition.fadeIn,
                );
              // case "/existing":
              //   return GetPageRoute(
              //       routeName: "existing",
              //       page: () => AddExistingCollection(),
              //       transition: Transition.fadeIn);
              default:
                return GetPageRoute(page: () => Container());
            }
          },
        ),
      ),
    ],
  );
}
