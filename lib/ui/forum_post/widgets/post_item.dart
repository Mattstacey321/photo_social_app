import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/constraint.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/widgets/circle_icon.dart';
import 'package:photo_social/widgets/custom_avatar.dart';
import 'package:photo_social/widgets/custom_button.dart';

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
        height: 250,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 15,
              offset: Offset(0,2)
              
            )
          ]
        ),
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
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(imageBorder),
                        onTap: () {
                          //view image in large view
                          viewFullScreen(imageUrl);
                        },
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                height: imageHeight,
                                width: imageWidth,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(imageBorder),
                                ),
                              ),
                              placeholderFadeInDuration: Duration(milliseconds: 300),
                              errorWidget: (context, url, error) => Container(
                                height: imageHeight,
                                width: imageWidth,
                                alignment: Alignment.center,
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(imageBorder)),
                                child: Icon(FeatherIcons.x),
                              ),
                              imageBuilder: (context, imageProvider) => Container(
                                height: imageHeight,
                                width: imageWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(imageBorder),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            // must add here to give splash effect
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.grey.withOpacity(0.2),
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                );
              },
              options: CarouselOptions(
                height: 250,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                viewportFraction: 1,
              ),
            ),
            Positioned(
              top: 20,
              right: 10,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Mattstacey",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        CustomAvatar(
                          url: AppConstraint.defaultAvatar,
                          onTap: () {
                            //go to profle
                          },
                          size: 30,
                          toolTip: "Avatar",
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 20,
              left: 20,
              right: 20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(),
                          child: Row(
                            children: [
                              /*Row(
                            children: [Icon(FeatherIcons.heart), SizedBox(width: 10), Text("10")],
                          ),*/
                              CustomButton(
                                onPress: () {
                                  //show reaction
                                },
                                tooltip: "",
                                opacity: 0,
                                iconColor: Colors.white,
                                icon: EvaIcons.heartOutline,
                                width: 50,
                                childs: [
                                  Text(
                                    model.totalReaction.toString(),
                                    style: TextStyle(color: Colors.white),
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
                                icon: EvaIcons.messageCircleOutline,
                                width: 50,
                                childs: [
                                  Text(
                                    model.totalComment.toString(),
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
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
            Positioned(
              left: 5,
              top: 5,
              child: CircleIcon(
                onTap: () => _.getImageInfo(),
                child: Icon(
                  EvaIcons.info,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  viewFullScreen(String url) {
    //Get.dialog(child);
  }
}
