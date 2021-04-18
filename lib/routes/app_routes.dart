import 'package:get/get.dart';

import '../modules/authentication/bindings/authentication_bindings.dart';
import '../modules/authentication/views/authentication_root.dart';
import '../modules/base/bindings/base_binding.dart';
import '../modules/base/views/base_screen.dart';
import '../modules/collection/views/collections_root.dart';
import '../modules/forum_detail/views/forum_detail.dart';
import '../modules/start_up/bindings/startup_bindings.dart';
import '../modules/start_up/startup_screen.dart';
import 'routes.dart';
class AppPages {
  static const INITIAL = Routes.INITIAL;
  static final routes = [
    GetPage(
      name: Routes.STARTUP,
      binding: StartUpBindings(),
      page: () => StartUpScreen(),
    ),
    GetPage(
        name: Routes.LOGIN,
        binding: AuthenticationBindings(),
        page: () => AuthenticationView(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
      name: Routes.FORUMPOST,
      page: () => ForumDetailView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.HOME,
      binding: BaseBindings(),
      page: () => BaseScreen(),
    ),
    GetPage(
      name: Routes.COLLECTION,
      page: () => CollectionsRoot(),
    )
  ];
}
