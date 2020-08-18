import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/constraint.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/ui/forum_post/widgets/post_image_info.dart';
import 'package:photo_social/utils/time_ago.dart';
import 'package:photo_social/widgets/circle_icon.dart';
import 'package:photo_social/widgets/custom_avatar.dart';
import 'package:photo_social/widgets/custom_button.dart';
import 'package:photo_social/widgets/custom_netword_image.dart';

class PostItem extends StatelessWidget {
  final PostModel model;
  final double imageBorder;
  final bool isLike;
  final String imageQuality;
  PostItem(
      {@required this.model,
      @required this.isLike,
      this.imageQuality = 'medium',
      this.imageBorder = 10});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(builder: (_) {
      return Container(
        height: 300,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                children: [
                  CustomAvatar(
                    url: AppConstraint.defaultAvatar,
                    onTap: () {
                      //go to profle
                    },
                    size: 35,
                    toolTip: "Avatar",
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Mattstacey",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Spacer(),
                  SizedBox(width: 10),
                  Text(getTime(time: model.createdTime.toString(), locale: 'en')),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            model.postTitle != "" ? Text(model.postTitle) : Container(),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: model.countMedia,
                    itemBuilder: (context, index) {
                      double imageHeight = model.medias[index].height;
                      double imageWidth = Get.width;
                      String imageUrl = imageQuality == "hight"
                          ? model.medias[index].original
                          : imageQuality == "medium"
                              ? model.medias[index].thumb1
                              : model.medias[index].thumb2;
                      return CustomNetworkImage(
                          url: imageUrl,
                          onTap: () {
                            //view image in large view
                            viewFullScreen(
                              medias: model.medias,
                              blurHash: model.medias[index].blurHash,
                            );
                          },
                          imageHeight: imageHeight,
                          imageWidth: imageWidth);
                    },
                    options: CarouselOptions(
                        height: 250,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        viewportFraction: 0.98,
                        onPageChanged: (index, reason) => _.setIndicatorIndex(index)),
                  ),
                  Positioned.fill(
                    right: 0,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            model.medias.length > 1
                                ? Obx(
                                    () => Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        children: model.medias.map((url) {
                                          int index = model.medias.indexOf(url);
                                          return Container(
                                            width: 10,
                                            height: 10,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 0.0, horizontal: 5.0),
                                            decoration: BoxDecoration(
                                              
                                              shape: BoxShape.circle,
                                              color: _.currentIndicatorIndex == index
                                                  ? Colors.white
                                                  : Colors.white.withOpacity(0.2),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            Spacer(),
                            CircleIcon(
                              onTap: () => _.getImageInfo(),
                              child: Icon(
                                EvaIcons.info,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //blur like and comment icon
                  Positioned.fill(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: 35,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  BackdropFilter(
                                    filter: ImageFilter.blur(),
                                    child: Container(
                                      height: 38,
                                      width: 125,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.35),
                                          borderRadius: BorderRadius.circular(15)),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      CustomButton(
                                        onPress: () {
                                          //show reaction
                                        },
                                        tooltip: "",
                                        opacity: 0,
                                        iconColor: Colors.white,
                                        icon: FeatherIcons.heart,
                                        width: 50,
                                        childs: [
                                          Text(
                                            model.totalReaction.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      CustomButton(
                                        onPress: () {
                                          //show comment
                                        },
                                        tooltip: "",
                                        opacity: 0,
                                        iconColor: Colors.white,
                                        icon: FeatherIcons.message_circle,
                                        width: 50,
                                        childs: [
                                          Text(
                                            model.totalComment.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: CustomButton(
                              onPress: () {
                                _.likePost(postId: model.postId);
                              },
                              tooltip: "Mlem mlem",
                              iconColor: Colors.pink,
                              backgroundColor: Colors.white,
                              icon: isLike ? EvaIcons.heart : EvaIcons.heartOutline,
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                for (var item in model.tags)
                  Chip(
                    label: Text(item),
                  ),
                SizedBox(width: 20)
              ],
            )
          ],
        ),
      );
    });
  }

  viewFullScreen({List<Media> medias, String blurHash}) {
    Get.dialog(PostImageInfo(
      blurHash: blurHash,
      media: medias,
    ));
  }
}
