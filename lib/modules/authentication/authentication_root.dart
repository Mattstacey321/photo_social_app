import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/widgets/app_bar/custom_appBar.dart';

import 'auth_controller.dart';
import '../sign_in/sign_in.dart';
import '../sign_up/sign_up.dart';
import 'widgets/index.dart';

class AuthenticationRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: BoxConstraints(),
        child: IntrinsicHeight(
            child: GetBuilder<AuthController>(
          init: AuthController(),
          autoRemove: false,
          builder: (_) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: CustomAppBar(
                  height: 52,
                  childs: [],
                  tabBar: AuthenticationTabBar(
                    tabController: _.tabController,
                  ),
                ),
                body: TabBarView(
                  controller: _.tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SignIn(),
                    SignUp(),
                  ],
                ),
              ),
            );
          },
        )),
      ),
    );
  }
}
