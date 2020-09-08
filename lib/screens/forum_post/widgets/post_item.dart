import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_social/constraint.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/utils/time_ago.dart';
import 'package:photo_social/widgets/custom_avatar.dart';
import 'package:photo_social/widgets/custom_button.dart';
import 'package:photo_social/widgets/custom_netword_image.dart';

import 'post_image_detail.dart';

class PostItem extends StatefulWidget {
  final PostModel model;
  final bool hideHashTag;
  final double imageBorder;
  final bool isLike;
  final String imageQuality;
  PostItem(
      {@required this.model,
      @required this.isLike,
      this.hideHashTag = false,
      this.imageQuality = 'medium',
      this.imageBorder = 10});

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  int _currentPage = 0;

  Widget buildTotalImage() {
    return Container(
        height: 30,
        width: 50,
        child: Stack(alignment: Alignment.center, children: [
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
          Text(
            "${_currentPage + 1} / ${widget.model.medias.length}",
            style: TextStyle(color: Colors.white),
          ),
        ]));
  }

  Widget buildPostTitle() {
    return widget.model.postTitle != ""
        ? Text(widget.model.postTitle)
        : Container();
  }

  Widget buildHashTag() {
    return widget.hideHashTag
        ? Container()
        : Container(
            height: 20,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemCount: widget.model.tags.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Text(
                      "#${widget.model.tags[index]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
          );
  }

  Widget buildIndicator() {
    return Container(
      height: 50,
      child: Align(
        alignment: Alignment.centerRight,
        child: widget.model.medias.length > 1
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: widget.model.medias.map((url) {
                    int index = widget.model.medias.indexOf(url);
                    return Container(
                      width: 5,
                      height: 5,
                      margin:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.black
                            : Colors.grey.withOpacity(0.6),
                      ),
                    );
                  }).toList(),
                ),
              )
            : SizedBox(),
      ),
    );
  }

  Widget buildLikeComment(PostController _) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //blur like and comment icon
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 35,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    LikeButton(
                      size: 30,
                      isLiked: widget.isLike,
                      circleColor: CircleColor(
                          start: Colors.pink,
                          end: Colors.pink.withOpacity(0.5)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Colors.pink,
                        dotSecondaryColor: Colors.pink.withOpacity(0.5),
                      ),
                      onTap: (isLiked) {
                        return _.likePost(
                            postId: widget.model.postId, isLiked: isLiked);
                      },
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          isLiked ? EvaIcons.heart : EvaIcons.heart,
                          color: isLiked ? Colors.pink : Colors.grey,
                          size: 26,
                        );
                      },
                      likeCount: widget.model.totalReaction,
                      countBuilder: (int count, bool isLiked, String text) {
                        Widget result;
                        result = Text(
                          text,
                          style: TextStyle(
                              color: isLiked ? Colors.pink : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        );
                        return result;
                      },
                      animationDuration: Duration(milliseconds: 250),
                    ),
                    SizedBox(width: 10),
                    CustomButton(
                      onPress: () {
                        //show comment
                      },
                      tooltip: "",
                      opacity: 0,
                      iconColor: Colors.grey,
                      icon: EvaIcons.messageCircle,
                      width: 50,
                      childs: [
                        Text(
                          widget.model.totalComment.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        /*Spacer(),
        buildIndicator()*/
      ],
    );
  }

  Widget buildCreator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAvatar(
            url: AppConstraint.defaultAvatar,
            onTap: () {
              //go to profle
            },
            size: 40,
            toolTip: "Avatar",
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Admin",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    EvaIcons.checkmarkCircle2,
                    color: Colors.green,
                    size: 15,
                  )
                ],
              ),
              Text("Creator"),
            ],
          ),
          Spacer(),
          SizedBox(width: 10),
          Text(
              getTime(time: widget.model.createdTime.toString(), locale: 'en')),
        ],
      ),
    );
  }

  Widget buildPostImage() {
    return Flexible(
      child: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: widget.model.countMedia,
            itemBuilder: (context, index) {
              double imageHeight = widget.model.medias[index].height;
              double imageWidth = widget.model.medias[index].width;
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
          Positioned(top: 6, right: 10, child: buildTotalImage()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(builder: (_) {
      return Container(
        height: Get.height * 0.45,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCreator(),
            SizedBox(
              height: 10,
            ),
            buildPostTitle(),
            SizedBox(
              height: 10,
            ),
            buildHashTag(),
            SizedBox(
              height: 10,
            ),
            buildPostImage(),
            buildLikeComment(_),
          ],
        ),
      );
    });
  }

  void viewFullScreen({int index, List<Media> medias}) async {
    return Get.dialog(
        PostImageInfo(
          index: index,
          media: medias,
        ),
        useRootNavigator: true);
  }
}
