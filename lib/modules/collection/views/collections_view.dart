import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../responsive_view/collection_view_desktop.dart';
import '../responsive_view/collection_view_mobile.dart';

class CollectionsView extends GetResponsiveView {
  CollectionsView() : super(alwaysUseBuilder: false);
  @override
  Widget phone() {
    return CollectionViewMobile();
  }

  @override
  Widget desktop() {
    return CollectionViewDesktop();
  }
}
