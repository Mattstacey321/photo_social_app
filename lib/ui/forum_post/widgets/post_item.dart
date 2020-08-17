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
  final Function onTap;
  final double imageBorder;
  final bool isLike;
  PostItem(
      {@required this.model, @required this.onTap, @required this.isLike, this.imageBorder = 10});
  @override
  Widget build(BuildContext context) {
    double imageHeight = 250;
    double imageWidth = Get.width;
    return GetBuilder<PostController>(builder: (_) {
      return Container(
        height: 250,
        width: Get.width,
        child: Stack(
          children: [
            CarouselSlider.builder(
              itemCount: model.countMedia,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(imageBorder),
                        onTap: onTap,
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: model.medias[index].original,
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
                                  onTap: onTap,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                );
              },
              options: CarouselOptions(
                height: imageHeight,
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
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
