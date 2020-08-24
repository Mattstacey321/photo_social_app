import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/ui/forum_post/forum_post.dart';
import 'package:photo_social/ui/home/home.dart';
import 'package:photo_social/ui/login/login.dart';
import 'package:photo_social/ui/profile/profile.dart';
import 'package:photo_social/ui/sign_up/sign_up.dart';

import 'routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.LOGIN, page: () => Login(), transition: Transition.fade),
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
