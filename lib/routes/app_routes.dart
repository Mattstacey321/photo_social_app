import 'package:get/get.dart';
import 'package:photo_social/modules/app_screen.dart';
import 'package:photo_social/modules/base/base_binding.dart';
import 'package:photo_social/modules/base/base_screen.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = Routes.INITIAL;
  static final routes = [
    GetPage(
        name: Routes.LOGIN,
        page: () => AuthenticationRoot(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.FORUMPOST,
        page: () => ForumPost(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.HOME,
        page: () => BaseScreen(),
        binding: BaseBinding(),
        children: [
          GetPage(name: Routes.BOOKMARK, page: () => Home()),
          /*GetPage(name: Routes.BOOKMARK, page: () => BookmarkRoot()),
          GetPage(name: Routes.PROFILE, page: () => ProfileRoot()),*/
        ]),
  ];
}
