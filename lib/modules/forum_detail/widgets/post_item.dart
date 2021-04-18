import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../../constraint.dart';
import '../../../data/models/post_model.dart';
import '../../../data/utils/get_social_id.dart';
import '../../../data/utils/open_as_uri.dart';
import '../../../data/utils/social_icon.dart';
import '../../../data/utils/time_utils.dart';
import '../../../global_widgets/index.dart';
import '../../../src/bottom_sheet/comment.dart';
import '../../base/controllers/base_controller.dart';
import '../../post_detail/views/post_detail_view.dart';
import '../../theme/theme_controller.dart';
import '../controllers/post_controller.dart';
import 'bookmark_button.dart';

class PostItem extends StatefulWidget {
  final PostModel post;
  final bool hideHashTag;
  final String imageQuality;
  PostItem({
    @required this.post,
    this.hideHashTag = false,
    this.imageQuality = 'medium',
  });

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> with AutomaticKeepAliveClientMixin {
  int _currentPage = 0;
  var listSocial = [];

  PostModel get post => widget.post;
  List get tags => post.tags;
  int get tagCount => post.tags.length;
  int get mediaCount => post.medias.length;
  List<Media> get medias => post.medias;
  String get postTitle => post.title;
  bool get isBookmark => post.isBookmarked;
  bool get isReaction => post.isReactioned;
  String get postId => post.postId;
  String get forumId => post.forumId;
  String get createdTime => post.createdTime.toString();
  String get totalComment => post.totalComment.toString();
  int get totalReaction => post.totalReaction;
  int get countMedia => post.countMedia;
  String get postFirstImage => post.medias.first.thumb1;
  String get imageQuality => widget.imageQuality;
  String get currentTime => TimeUtils().getCurrentTime(time: createdTime);

  @override
  void initState() {
    super.initState();
    listSocial = getUserSocial(postTitle);
  }

  Widget buildTotalImage() {
    return Container(
      height: 30,
      width: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(),
            child: Container(
              height: 40,
              width: 125,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Text(
            "${_currentPage + 1} / $mediaCount",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPostInfo(Animation<double> animation, Function onTap,
      {IconData icon, String name, String socialId}) {
    return SlideTransition(
      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(
          CurvedAnimation(parent: animation, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
      child: Container(
        height: 35,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [Icon(icon), SizedBox(width: 5), Text("$name: "), Text("$socialId}")],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPostInfo() {
    return CircleIcon(
      onTap: () {
        int totalItem = listSocial.length;
        totalItem == 0
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
                        height: (50 * totalItem).toDouble(),
                        width: GetPlatform.isDesktop ? 250 : Get.width - 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(height: 5),
                          itemCount: totalItem,
                          itemBuilder: (context, index) {
                            final social = listSocial[index];
                            switch (social.type) {
                              case "fb":
                                return _buildPostInfo(
                                    animation, () => OpenWith.facebook(id: social.id),
                                    icon: SocialIcon.facebook_f,
                                    name: "Facebook",
                                    socialId: social.id);
                                break;
                              case "weibo":
                                return _buildPostInfo(
                                    animation, () => OpenWith.weibo(id: social.id),
                                    icon: SocialIcon.weibo, name: "Weibo", socialId: social.id);
                                break;
                              case "ig":
                                return _buildPostInfo(
                                    animation, () => OpenWith.instagram(id: social.id),
                                    icon: SocialIcon.instagram,
                                    name: "Instagram",
                                    socialId: social.id);
                              default:
                                return _buildPostInfo(
                                    animation, () => OpenWith.twitter(id: social.id),
                                    icon: SocialIcon.twitter, name: "Twitter", socialId: social.id);
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
                transitionBuilder: (context, animation, secondaryAnimation, child) {
                  return Transform.translate(
                    offset: Offset(animation.value, animation.value * 15),
                    child: Opacity(opacity: animation.value, child: child),
                  );
                },
                barrierDismissible: true,
                barrierLabel: "Dissmiss Info");
      },
      tooltip: "Info",
      icon: Icon(
        EvaIcons.info,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  Widget buildHashTag() {
    return widget.hideHashTag
        ? const SizedBox()
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
              ),
            ),
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
                      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? Colors.black : Colors.grey.withOpacity(0.6),
                      ),
                    );
                  }).toList(),
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  Widget buildLikeComment() {
    Color color = ThemeController.to.isDarkMode.value ? Colors.white : Colors.black;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Container(
        width: Get.width - 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //blur like and comment icon
            Container(
              height: 35,
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  LikeButton(
                    size: 30,
                    isLiked: isReaction,
                    likeCountAnimationType: LikeCountAnimationType.all,
                    circleColor: CircleColor(start: Colors.pink, end: Colors.pink.withOpacity(0.5)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Colors.pink,
                      dotSecondaryColor: Colors.pink.withOpacity(0.5),
                    ),
                    onTap: (isLiked) async {
                      //print(forumId);
                      return await PostController.to.likePost(
                        forumId: forumId,
                        postId: postId,
                        isLiked: isLiked,
                      );
                    },
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        isLiked ? EvaIcons.heart : EvaIcons.heartOutline,
                        color: isLiked ? Colors.pink : color,
                        size: 26,
                      );
                    },
                    likeCount: totalReaction,
                    countBuilder: (int count, bool isLiked, String text) {
                      return Text(
                        text,
                        style: TextStyle(
                            color: isLiked ? Colors.pink : color,
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
                      //showComment(postId: postId);
                      //TODO: open end drawer
                      GetPlatform.isDesktop
                          ? BaseController.to.drawerKey.currentState.openEndDrawer()
                          : showComment(postId: postId);
                      ;
                    },
                    tooltip: "Comment",
                    opacity: 0,
                    iconColor: color,
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
                  BookmarkButton(
                    forumId: forumId,
                    postId: postId,
                    isBookmarked: isBookmark,
                    postFirstImage: postFirstImage,
                  )
                ],
              ),
            ),
            /*Spacer(),
            buildIndicator()*/
          ],
        ),
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
              Text(currentTime),
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
            itemBuilder: (context, index, realIndex) {
              final double imageHeight = medias[index].height;
              final double imageWidth = medias[index].width;
              final String imageUrl = imageQuality == "hight"
                  ? medias[index].original
                  : imageQuality == "medium"
                      ? medias[index].thumb1
                      : medias[index].thumb2;
              final String blurHash = medias[index].blurHash;
              return CustomNetworkImage(
                url: imageUrl,
                onTap: () {
                  //view image in large view
                  viewFullScreen(
                    postId: postId,
                    index: _currentPage,
                    medias: medias,
                  );
                },
                blurHash: blurHash,
                imageHeight: imageHeight,
                imageWidth: imageWidth,
              );
            },
            options: CarouselOptions(
                height: 300,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                viewportFraction: 0.98,
                onPageChanged: (index, reason) {
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
  }

  void viewFullScreen({@required String postId, int index, List<Media> medias}) async {
    return Get.dialog(
      PostDetailView(
        postId: postId,
        index: index,
        media: medias,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
