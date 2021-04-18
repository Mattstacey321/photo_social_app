import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../responsive_view/home_desktop.dart';
import '../responsive_view/home_mobile.dart';

class HomeView extends GetResponsiveView {
  @override
  Widget phone() {
    return HomeMobile();
  }

  @override
  Widget desktop() {
    return HomeDesktop();
  }
}