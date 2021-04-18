import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import '../responsive_view/profile_desktop.dart';
import '../responsive_view/profile_mobile.dart';

class ProfileView extends GetResponsiveView<ProfileController> {
  @override
  Widget desktop() {
    return ProfileDesktop();
  }

  @override
  Widget phone() {
    return ProfileMobile();
  }
}
