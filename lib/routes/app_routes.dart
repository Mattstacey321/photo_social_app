import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/screens/index.dart';

import 'routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.LOGIN, page: () => Login(), transition: Transition.leftToRightWithFade),
    GetPage(name: Routes.SIGNUP, page: () => SignUp(), transition: Transition.rightToLeftWithFade),
    GetPage(name: Routes.FORUMPOST, page: () => ForumPost(), transition: Transition.fade),
    GetPage(name: Routes.PROFILE, page: () => Profile(), transition: Transition.fade),
    GetPage(
        name: Routes.HOME,
        page: () => Home(),
        transition: Transition.native,
        opaque: false,
        binding: BaseController()),
  ];
}
