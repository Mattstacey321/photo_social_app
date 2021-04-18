import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../global_widgets/index.dart';
import '../../sign_in/views/sign_in.dart';
import '../../sign_up/views/sign_up.dart';
import '../controllers/auth_controller.dart';
import '../widgets/authentication_tabbar.dart';

class AuthenticationView extends GetResponsiveView<AuthController> {
  @override
  Widget desktop() {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(100.0),
                child: SvgPicture.asset("assets/image/svgs/login_bg.svg"),
              )
            ),
            Expanded(
              child: Scaffold(
                appBar: CustomAppBar(
                  childs: [],
                  tabBar: AuthenticationTabBar(
                    tabController: controller.tabController,
                  ),
                ),
                body: TabBarView(
                  controller: controller.tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SignIn(),
                    SignUp(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget phone() {
    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: BoxConstraints(),
        child: IntrinsicHeight(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: CustomAppBar(
                height: 52,
                childs: [],
                tabBar: AuthenticationTabBar(
                  tabController: controller.tabController,
                ),
              ),
              body: TabBarView(
                controller: controller.tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SignIn(),
                  SignUp(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
