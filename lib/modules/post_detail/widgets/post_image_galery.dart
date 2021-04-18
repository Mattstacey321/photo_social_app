import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../data/models/post_model.dart';
import '../../../global_widgets/index.dart';
import '../../../src/loading_indicator/loading_indicator.dart';
import '../controllers/post_detail_controller.dart';
import 'toolbar.dart';

class PostImageGalery extends GetView<PostDetailController> {
  final List<Media> media;
  PostImageGalery({@required this.media});
  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (currentIndex) => Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: BlurHash(
                    hash: media[currentIndex.value].blurHash,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: PhotoViewGallery.builder(
                    pageController: controller.pageController,
                    itemCount: media.length,
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: CachedNetworkImageProvider(media[index].original),
                        initialScale: PhotoViewComputedScale.covered,
                        disableGestures: true,
                      );
                    },
                    onPageChanged: (index) => controller.setGaleryImageIndex(index),
                    loadingBuilder: (context, event) => Center(
                      child: LoadingIndicator.listLoading(),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.transparent,
                    child: media.length == 1
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              currentIndex.value == 0
                                  ? const SizedBox()
                                  : CircleIcon(
                                      onTap: () {
                                        controller.navigateLeft();
                                      },
                                      icon: Icon(
                                        EvaIcons.arrowBack,
                                      ),
                                      tooltip: "Left"),
                              currentIndex.value == media.length - 1
                                  ? const SizedBox()
                                  : CircleIcon(
                                      onTap: () {
                                        controller.navigateRight();
                                      },
                                      icon: Icon(
                                        EvaIcons.arrowForward,
                                      ),
                                      tooltip: "Right")
                            ],
                          ),
                  ),
                ),
                Positioned(
                  child: Toolbar(imageUrl: media[currentIndex.value].original),
                ),
              ],
            ),
          ),
        ],
      ),
      controller.currentImageIndex,
    );
  }
}
