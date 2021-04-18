import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/utils/nested_key.dart';
import '../../global_widgets/index.dart';
import '../../modules/bookmark/controllers/bookmark_controller.dart';
import '../../modules/bookmark/navigator/add_collection.dart';
import '../../modules/bookmark/navigator/add_existing_collection.dart';
import '../../modules/bookmark/navigator/modify_collection.dart';
import '../../modules/collection/controllers/collection_controller.dart';
import '../../modules/theme/theme_controller.dart';

Future showBookmarkBottomsheet() => Get.bottomSheet(
      CollectionAction(),
      backgroundColor: ThemeController.to.colorScheme,
      elevation: 1,
      isDismissible: true,
      persistent: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );

class CollectionAction extends StatelessWidget {
  //final String namedRoute;
  //CollectionAction({this.namedRoute});
  @override
  Widget build(BuildContext context) {
    return GetX<BookmarkController>( 
      builder: (_) {
        return Container(
          height: Get.height / 2,
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: Navigator(
                  initialRoute: '/',
                  key: Get.nestedKey(NestedKey.addCollection),
                  onPopPage: (route, result) {
                    if (!route.didPop(result)) return false;
                    return true;
                  },
                  onGenerateRoute: (settings) {
                    switch (settings.name) {
                      case "/new":
                        return GetPageRoute(
                            routeName: "new",
                            page: () => AddCollection(),
                            transition: Transition.fadeIn);
                      case "/modify":
                        return GetPageRoute(
                            routeName: "modify",
                            page: () => ModifyCollection(),
                            transition: Transition.fadeIn);
                      case "/existing":
                        return GetPageRoute(
                            routeName: "existing",
                            page: () => AddExistingCollection(),
                            transition: Transition.fadeIn);
                      default:
                        return GetPageRoute(page: () => Container());
//                        Exception('Invalid route: ${settings.name}');
                    }
                  },
                ),
              ),

              // button handle for 2 page
              LoadingButton(
                controller: _.bookmarkCtrl,
                height: 50,
                width: Get.width,
                onPressed:
                    CollectionController.to.collectionLength > 0 && _.collectionSelected.isNotEmpty
                        ? () async {
                            print("on page add to exist");
                            await BookmarkController.to.addToExistingCollection();
                          }
                        : CollectionController.to.collectionLength < 0 &&
                                _.isCollectionNameValidated.value
                            ? () async {
                                print("on page add new collection");
                                await BookmarkController.to.addToNewCollection();
                              }
                            : _.isCollectionNameValidated.value
                                ? () async {
                                    print("on page modify");
                                  }
                                : null,
                radius: 10,
                buttonColor: Colors.blue,
                initialWidget: Text(
                  "Done",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                successWidget: Icon(EvaIcons.checkmark),
                errorWidget: Icon(EvaIcons.close),
              ),
            ],
          ),
        );
      },
    );
  }
}

String buildAppbarTitle(String namedRoute) {
  switch (namedRoute) {
    case "/new":
      return "CREATE NEW COLLECTION";
    case "/modify":
      return "MODIFY";
    case "/existing":
      return "ADD TO EXISTING";
    default:
      return "...";
  }
}

String buildButtonTitle(String namedRoute) {
  switch (namedRoute) {
    case "/new":
      return "Create";
    case "/modify":
      return "Save";
    case "/existing":
      return "Update";
    default:
      return "...";
  }
}

Widget buildAppBar(String namedRoute) {
  switch (namedRoute) {
    case "/new":
      return CustomAppBar(childs: [
        Text(
          buildAppbarTitle(namedRoute),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ], onTapBack: () {});
    case "/modify":
      return CustomAppBar(
        childs: [],
        onTapBack: () => Get.back(),
      );
    case "/existing":
      return CustomAppBar(childs: [
        Text(
          buildAppbarTitle(namedRoute),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        // go to second page
        GestureDetector(
          onTap: () => Get.toNamed("/new", id: NestedKey.addCollection),
          child: Icon(
            EvaIcons.plus,
            size: 20,
          ),
        ),
      ]);
    default:
      return SizedBox();
  }
}