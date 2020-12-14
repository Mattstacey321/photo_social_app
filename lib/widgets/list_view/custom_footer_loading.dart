import 'package:flutter/material.dart';
import 'package:photo_social/src/loading_indicator/loading_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SRLoadingState {
  static get loadMore {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("pull up load");
        } else if (mode == LoadStatus.loading) {
          body = LoadingIndicator.footerLoading();
        } else if (mode == LoadStatus.failed) {
          body = Text("Load Failed! Click retry!");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("release to load more");
        } else {
          body = Text("You reach the end.");
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }

  static get refresh {}
}
