import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_social/constraint.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/utils/time_ago.dart';
import 'package:photo_social/widgets/circle_icon.dart';
import 'package:photo_social/widgets/custom_avatar.dart';
import 'package:photo_social/widgets/custom_button.dart';
import 'package:photo_social/widgets/custom_netword_image.dart';

import 'post_image_info.dart';

class PostItem extends StatefulWidget {
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
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  int _currentPage = 0;
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
                  Text(getTime(time: widget.model.createdTime.toString(), locale: 'en')),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            widget.model.postTitle != "" ? Text(widget.model.postTitle) : Container(),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: widget.model.countMedia,
                    itemBuilder: (context, index) {
                      double imageHeight = widget.model.medias[index].height;
                      double imageWidth = Get.width;
                      String imageUrl = widget.imageQuality == "hight"
                          ? widget.model.medias[index].original
                          : widget.imageQuality == "medium"
                              ? widget.model.medias[index].thumb1
                              : widget.model.medias[index].thumb2;
                      String blurHash = widget.model.medias[index].blurHash;
                      List<Media> medias = widget.model.medias;

                      return CustomNetworkImage(
                          url: imageUrl,
                          onTap: () {
                            //view image in large view
                            viewFullScreen(
                              index: _currentPage,
                              medias: medias,
                              blurHash: blurHash,
                            );
                          },
                          blurHash: blurHash,
                          imageHeight: imageHeight,
                          imageWidth: imageWidth);
                    },
                    options: CarouselOptions(
                        height: 250,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        viewportFraction: 0.98,
                        onPageChanged: (index, reason) {
                          //print("${widget.model.medias[index].name} $index");
                          setState(() {
                            _currentPage = index;
                          });
                        }),
                  ),
                  Positioned.fill(
                    right: 0,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.model.medias.length > 1
                                ? Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: widget.model.medias.map((url) {
                                        int index = widget.model.medias.indexOf(url);
                                        return Container(
                                          width: 10,
                                          height: 10,
                                          margin:
                                              EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _currentPage == index
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.2),
                                          ),
                                        );
                                      }).toList(),
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
                                      Container(
                                        child: LikeButton(
                                          size: 30,
                                          circleColor: CircleColor(
                                              start: Colors.pink,
                                              end: Colors.pink.withOpacity(0.5)),
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor: Colors.pink,
                                            dotSecondaryColor: Colors.pink.withOpacity(0.5),
                                          ),
                                          /*onTap: (isLiked) =>
                                              _.likePost(postId: widget.model.postId),*/
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                              isLiked ? EvaIcons.heart : EvaIcons.heartOutline,
                                              color: isLiked ? Colors.pink : Colors.white,
                                              size: 26,
                                            );
                                          },
                                          likeCount: widget.model.totalReaction,
                                          countBuilder: (int count, bool isLiked, String text) {
                                            Widget result;
                                            result = Text(
                                              text,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            );
                                            return result;
                                          },
                                          animationDuration: Duration(milliseconds: 500),
                                        ),
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
                                            widget.model.totalComment.toString(),
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
                          Spacer()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: Get.width,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemCount: widget.model.tags.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Chip(
                  label: Text(widget.model.tags[index]),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  viewFullScreen({int index, List<Media> medias, String blurHash}) {
    Get.dialog(
        PostImageInfo(
          index: index,
          blurHash: blurHash,
          media: medias,
        ),
        useRootNavigator: true);
  }
}
