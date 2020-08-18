import 'package:bot_toast/bot_toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/widgets/custom_button.dart';
import 'package:photo_social/widgets/custom_netword_image.dart';

class PostImageInfo extends StatelessWidget {
  final List<Media> media;
  final String blurHash;
  PostImageInfo({this.media, this.blurHash = ""});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            CarouselSlider.builder(
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
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                viewportFraction: 1,
              ),
            ),
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
                      iconColor: Colors.black.withOpacity(0.5),
                      backgroundColor: Colors.white.withOpacity(0.3),
                      showElevation: true,
                      height: 40,
                      width: 40,
                      radius: 10,
                      childs: [
                        Icon(
                          FeatherIcons.x,
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
                      iconColor: Colors.black.withOpacity(0.5),
                      backgroundColor: Colors.white.withOpacity(0.3),
                      showElevation: true,
                      height: 40,
                      width: 60,
                      radius: 10,
                      childs: [
                        Text(
                          "More",
                          style: TextStyle(),
                        )
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
  }
}
