import 'package:get/get.dart';
import 'package:photo_social/controller/base_controller.dart';
import 'package:photo_social/ui/home/home.dart';
import 'package:photo_social/ui/login/login.dart';
import 'package:photo_social/ui/sign_up/sign_up.dart';

import 'routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.LOGIN, page: () => Login(), transition: Transition.fade),
    GetPage(name: Routes.SIGNUP, page: () => SignUp(), transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.HOME,
        page: () => Home(),
        transition: Transition.native,
        binding: BaseController()),
  
  ];
}
