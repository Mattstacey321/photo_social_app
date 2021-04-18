import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/route_model.dart';
import '../../../data/utils/nested_key.dart';
import '../../collection/views/collections_root.dart';
import '../../hash_tag/controllers/hashtag_controller.dart';
import '../../hash_tag/controllers/hashtag_detail_controller.dart';
import '../../hash_tag/navigator/hashtag_detail.dart';
import '../../home/views/home_view.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.find();
  var drawerKey = GlobalKey<ScaffoldState>();

  var currentPageIndex = 0.obs;
  var routeHistory = [0].obs;

  var stack = <RouteModel>[
    RouteModel(page: "home", nestedKey: NestedKey.home, routes: ['/'], locked: true),
    RouteModel(page: "collection", nestedKey: NestedKey.collection, routes: ['/'], locked: true),
  ].obs;

  var pages = <Widget>[
    HomeView(),
    CollectionsRoot(),
    //ProfileRoot(),
  ].obs;

  @override
  void onInit() {
    ever(currentPageIndex, (int index) {
      // at home page
      switch (index) {
        case 0:
          setStackPage("home", "/", NestedKey.home);
          HashTagController.to.deselectedHashTag();
          break;
        case 1:
          setStackPage("collection", "/", NestedKey.collection);
          HashTagController.to.deselectedHashTag();
          break;
        /*case 2:
          setStackPage('hash-tag', '/', NestedKey.hashTag);
          break;*/
        default:
          null;
      }
    });
    super.onInit();
  }

  void changePage(int index) {
    //set old index
    routeHistory.addIf(!routeHistory.contains(index), index);
    //set new index
    currentPageIndex(index);
  }

  void addHashTagPage({@required String hashTag, String oldHashTag, bool hideHashTag = false}) {
    pages.removeWhere((element) => element.key == Key(oldHashTag));

    (hashTag == oldHashTag || oldHashTag == "")
        ? null
        : Get.delete<HashTagDetailController>(tag: oldHashTag);

    Get.put(HashTagDetailController(hashtag: hashTag), permanent: false, tag: hashTag);

    pages.add(HashTagDetail(
      key: Key(hashTag),
      hashTag: hashTag,
      hideHashTag: hideHashTag,
    ));
    
    changePage(pages.length - 1);
    setStackPage('hash-tag', hashTag, null);
    pages.refresh();
  }

  void addProfilePage() {}

  void setStackPage(String page, String route, int nestedKey) {
    //not exist page
    var currentRoute = stack.firstWhere((element) => element.page == page, orElse: () => null);
    if (currentRoute == null) {
      stack.add(RouteModel(page: page, routes: [route], nestedKey: nestedKey));
    } else {
      // add new route to existing page
      var newRoute = currentRoute.routes;
      newRoute.addIf(!currentRoute.routes.contains(route), route);
      currentRoute.copyWith(routes: newRoute);
    }
    stack.refresh();
  }

  void popStackPage() {
    final getRoutes = stack[currentPageIndex.value];
    if (getRoutes.routes.length == 1) {
      // containt 1 route => remove from stack
      stack.removeWhere((item) => item.locked == false);
      //
      routeHistory.removeAt(routeHistory.length - 1);
      // change page
      changePage(routeHistory.last);
      //changePage(currentPageIndex.value - 1);
    } else {
      // back on single page
      getRoutes.routes.removeLast();
      Get.back(id: getRoutes.nestedKey);
    }
  }
}
