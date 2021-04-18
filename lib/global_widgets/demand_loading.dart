import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../src/enum/enum_loading.dart';
import '../src/loading_indicator/loading_indicator.dart';

class DemandLoadingWidget extends StatelessWidget {
  final Rx<LoadingStatus> loadingStatus;
  final Widget onError;
  final Widget onLoading;
  final Widget onEmpty;
  final Widget child;
  DemandLoadingWidget(
    this.loadingStatus, {
    @required this.child,
    this.onLoading,
    @required this.onEmpty,
    @required this.onError,
  });
  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<LoadingStatus>>(
      (res) {
        switch (res.value) {
          case LoadingStatus.empty:
            return onEmpty;
          case LoadingStatus.error:
            return onError;
          case LoadingStatus.loading:
            return onLoading == null ? LoadingIndicator.listLoading() : onLoading;
          default:
            return child;
        }
      },
      loadingStatus,
    );
  }
}
