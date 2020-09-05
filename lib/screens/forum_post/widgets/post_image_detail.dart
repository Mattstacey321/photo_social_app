import 'package:bot_toast/bot_toast.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/post_detail_controller.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/widgets/custom_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PostImageInfo extends StatelessWidget {
  final int index;
  final List<Media> media;
  final String blurHash;
  PostImageInfo({this.index = 0, this.media, this.blurHash = ""});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostDetailController>(
        init: PostDetailController(pageIndex: index),
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Container(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  PhotoViewGallery.builder(
                    pageController: _.pageController,
                    itemCount: media.length,
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(media[index].original),
                        initialScale: PhotoViewComputedScale.contained * 1,
                        tightMode: true,
                        /*heroAttributes:
                            PhotoViewHeroAttributes(tag: media[index].id),*/
                      );
                    },
                    loadFailedChild: Center(
                      child: Text("Load fail"),
                    ),
                    //loadingBuilder: (context, event) => ,
                  ),
                  /*CarouselSlider.builder(
                carouselController: _.buttonCarouselController,
                itemCount: media.length,
                itemBuilder: (context, index) {
                  double imageHeight = media[index].height;
                  double imageWidth = media[index].width;
                  String imageUrl = media[index].original;
                  return CustomNetworkImage(
                    url: imageUrl,
                    onTap: null,
                    blurHash: blurHash,
                    imageBorder: 0,
                    imageHeight: imageHeight,
                    imageWidth: imageWidth,
                  );
                },
                options: CarouselOptions(
                  height: Get.height,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  viewportFraction: 1,
                ),
              ),*/
                  Positioned(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CustomButton(
                            onPress: () {
                              Get.back();
                            },
                            tooltip: "Close",
                            iconColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            //backgroundColor: Colors.white.withOpacity(0.6),
                            showElevation: true,
                            height: 40,
                            width: 40,
                            radius: 10,
                            childs: [
                              Icon(
                                FeatherIcons.x,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Spacer(),
                          CustomButton(
                            onPress: () {
                              BotToast.showText(text: "On Working feature.");
                            },
                            isClickable: false,
                            tooltip: "More",
                            iconColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            showElevation: true,
                            height: 40,
                            width: 40,
                            radius: 10,
                            childs: [
                              Icon(
                                FeatherIcons.more_vertical,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
