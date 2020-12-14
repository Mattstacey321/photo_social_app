import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_social/constraint.dart';
import 'package:photo_social/models/post_model.dart';
import 'package:photo_social/src/bottom_sheet/comment.dart';
import 'package:photo_social/themes/app_colors.dart';
import 'package:photo_social/themes/app_gradients.dart';
import 'package:photo_social/utils/get_social_id.dart';
import 'package:photo_social/utils/open_as_uri.dart';
import 'package:photo_social/utils/social_icon.dart';
import 'package:photo_social/utils/time_utils.dart';
import 'package:photo_social/widgets/index.dart';

import '../../post_image_detail/post_image_detail.dart';
import '../post_controller.dart';
import 'bookmark_button.dart';

class Post extends StatefulWidget {
  final PostModel model;
  final bool hideHashTag;
  final double imageBorder;
  final String imageQuality;
  Post(
      {@required this.model,
      this.hideHashTag = false,
      this.imageQuality = 'medium',
      this.imageBorder = 10});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> with AutomaticKeepAliveClientMixin {
  int _currentPage = 0;
  var listSocial = [];

  List get tags => widget.model.tags;
  int get tagCount => widget.model.tags.length;
  int get mediaCount => widget.model.medias.length;
  List<Media> get medias => widget.model.medias;
  String get postTitle => widget.model.postTitle;
  bool get isBookmark => widget.model.isBookmarked;
  bool get isReaction => widget.model.isReactioned;
  String get postId => widget.model.postId;
  String get forumId => widget.model.forumId;
  String get createdTime => widget.model.createdTime.toString();
  String get totalComment => widget.model.totalComment.toString();
  int get totalReaction => widget.model.totalReaction;
  int get countMedia => widget.model.countMedia;

  @override
  void initState() {
    super.initState();
    listSocial = getUserSocial(postTitle);
  }

  Widget buildTotalImage() {
    return Container(
        height: 30,
        width: 50,
        child: Stack(alignment: Alignment.center, children: [
          BackdropFilter(
            filter: ImageFilter.blur(),
            child: Container(
              height: 40,
              width: 125,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          Text(
            "${_currentPage + 1} / $mediaCount",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ]));
  }

  Widget infoItem(Animation<double> animation, Function onTap, Widget widget) {
    return SlideTransition(
      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(
          CurvedAnimation(
              parent: animation,
              curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
      child: Container(
        height: 35,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: widget,
          ),
        ),
      ),
    );
  }

  Widget buildPostInfo() {
    return CircleIcon(
      onTap: () {
        getUserSocial(postTitle).length == 0
            ? BotToast.showText(text: "No info")
            : Get.generalDialog(
                transitionDuration: Duration(milliseconds: 200),
                barrierColor: Colors.black.withOpacity(0.4),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Center(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 10000),
                          height: 100,
                          width: Get.width - 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 5),
                            itemCount: getUserSocial(postTitle).length,
                            itemBuilder: (context, index) {
                              final social = getUserSocial(postTitle)[index];
                              return social.type == 'fb'
                                  ? infoItem(
                                      animation,
                                      () => OpenWith.facebook(id: social.id),
                                      Row(
                                        children: <Widget>[
                                          Icon(SocialIcon.facebook_f),
                                          SizedBox(width: 5),
                                          Text("Facebook: "),
                                          Text("${social.id}")
                                        ],
                                      ),
                                    )
                                  : social.type == 'ig'
                                      ? infoItem(
                                          animation,
                                          () =>
                                              OpenWith.instagram(id: social.id),
                                          Row(
                                            children: [
                                              Icon(SocialIcon.instagram),
                                              SizedBox(width: 5),
                                              Text("Instagram: "),
                                              Text("${social.id}")
                                            ],
                                          ),
                                        )
                                      : social.type == 'weibo'
                                          ? infoItem(
                                              animation,
                                              () =>
                                                  OpenWith.weibo(id: social.id),
                                              Row(
                                                children: [
                                                  Icon(SocialIcon.weibo),
                                                  SizedBox(width: 5),
                                                  Text("Weibo: "),
                                                  Text("${social.id}")
                                                ],
                                              ),
                                            )
                                          : infoItem(
                                              animation,
                                              () => OpenWith.twitter(
                                                  id: social.id),
                                              Row(
                                                children: <Widget>[
                                                  Icon(SocialIcon.twitter),
                                                  SizedBox(width: 5),
                                                  Text("Twitter: "),
                                                  Text("${social.id}")
                                                ],
                                              ),
                                            );
                            },
                          )),
                    ),
                  );
                },
                transitionBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return Transform.translate(
                    offset: Offset(animation.value, animation.value * 15),
                    child: Opacity(opacity: animation.value, child: child),
                  );
                },
                barrierDismissible: true,
                barrierLabel: "Dissmiss Info");
      },
      tooltip: "Info",
      child: Icon(
        EvaIcons.info,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  Widget buildHashTag() {
    return widget.hideHashTag
        ? Container()
        : Container(
            height: 30,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemCount: tagCount,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Chip(
                      label: Text(
                        "#${tags[index]}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
          );
  }

  Widget buildIndicator() {
    return Container(
      height: 50,
      child: Align(
        alignment: Alignment.centerRight,
        child: mediaCount > 1
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: medias.map((url) {
                    int index = medias.indexOf(url);
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

  Widget buildLikeComment() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //blur like and comment icon
          Container(
            height: 35,
            width: Get.width - 20,
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                SizedBox(width: 10),
                LikeButton(
                  size: 30,
                  isLiked: isReaction,
                  likeCountAnimationType: LikeCountAnimationType.all,
                  circleColor: CircleColor(
                      start: Colors.pink, end: Colors.pink.withOpacity(0.5)),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: Colors.pink,
                    dotSecondaryColor: Colors.pink.withOpacity(0.5),
                  ),
                  onTap: (isLiked) {
                    return PostController.to.likePost(
                      forumId: forumId,
                      postId: postId,
                      isLiked: isLiked,
                    );
                  },
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      isLiked ? EvaIcons.heart : EvaIcons.heartOutline,
                      color: isLiked ? Colors.pink : Get.theme.iconTheme.color,
                      size: 26,
                    );
                  },
                  likeCount: totalReaction,
                  countBuilder: (int count, bool isLiked, String text) {
                    return Text(
                      text,
                      style: TextStyle(
                          color:
                              isLiked ? Colors.pink : Get.theme.iconTheme.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    );
                  },
                  likeCountAnimationDuration: Duration(milliseconds: 250),
                  animationDuration: Duration(milliseconds: 250),
                ),
                SizedBox(width: 10),
                CustomButton(
                  onPress: () {
                    //show comment
                    showComment(postId: postId);
                  },
                  tooltip: "",
                  opacity: 0,
                  iconColor: Get.theme.iconTheme.color,
                  icon: EvaIcons.messageCircleOutline,
                  width: 50,
                  childs: [
                    Text(
                      totalComment,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                Spacer(),
                BookmarkButton(
                  forumId: forumId,
                  postId: postId,
                  isBookmarked: isBookmark,
                  postFirstImage: widget.model.medias[0].thumb1,
                )
              ],
            ),
          ),
          /*Spacer(),
          buildIndicator()*/
        ],
      ),
    );
  }

  Widget buildCreator() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAvatar(
                url: AppConstraints.defaultAvatar,
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
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
              Text(getCurrentTime(time: createdTime)),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget buildPostImage() {
    return Flexible(
      child: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: countMedia,
            itemBuilder: (context, index) {
              final double imageHeight = medias[index].height;
              final double imageWidth = medias[index].width;
              final String imageUrl = widget.imageQuality == "hight"
                  ? medias[index].original
                  : widget.imageQuality == "medium"
                      ? medias[index].thumb1
                      : medias[index].thumb2;
              final String blurHash = medias[index].blurHash;
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
                height: 300,
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
          Positioned(top: 6, left: 10, child: buildTotalImage()),
          Positioned(right: 5, child: buildPostInfo()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<PostController>(builder: (_) {
      return Container(
        height: Get.height * 0.40,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //buildCreator(),
            //buildSocialProfile(),
            //buildHashTag(),
            buildPostImage(),
            buildLikeComment(),
          ],
        ),
      );
    });
  }

  void viewFullScreen({int index, List<Media> medias}) async {
    return Get.dialog(
        PostImageDetail(
          index: index,
          media: medias,
        ),
        useRootNavigator: true);
  }

  @override
  bool get wantKeepAlive => true;
}
