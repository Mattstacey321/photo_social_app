import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:photo_social/repository/forum_repository.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/widgets/custom_loading_state.dart';

class CustomNetworkImage extends StatelessWidget {
  final String id;
  final String url;
  final String title;
  final int number;
  final double imageBorder;
  final double imageHeight;
  final double imageWidth;
  final String blurHash;
  final Function onTap;
  const CustomNetworkImage(
      {@required this.url,
      @required this.id,
      this.imageBorder = 15,
      @required this.title,
      this.number = 0,
      this.blurHash = "",
      @required this.onTap,
      @required this.imageHeight,
      @required this.imageWidth});

  @override
  Widget build(BuildContext context) {
    Widget defaultPlaceHolder = blurHash == ""
        ? PlaceHolderWidget(
            imageBorder: imageBorder,
            imageHeight: imageHeight,
            imageWidth: imageWidth,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(imageBorder),
            child: BlurHash(hash: "r$blurHash"),
          );
    Widget defaultErrorHolder = ErrorHolderWidget(
      imageBorder: imageBorder,
      imageHeight: imageHeight,
      imageWidth: imageWidth,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(imageBorder),
        onTap: onTap,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => defaultPlaceHolder,
              errorWidget: (context, url, error) => defaultErrorHolder,
              placeholderFadeInDuration: Duration(milliseconds: 300),
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
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: AppStyle.bannerTitle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder(
                          future: ForumRepository.countForumPost(forumId: id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text(
                                "loading...",
                                style: AppStyle.bannerNumber,
                              );
                            } else
                              return Text(
                                "${snapshot.data.toString()} photos",
                                style: AppStyle.bannerNumber,
                              );
                          })
                    ],
                  ),
                ),
              ),
            ),
            // must add here to give splash effect
            Positioned.fill(
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.grey.withOpacity(0.2),
                      onTap: onTap,
                    ))),
          ],
        ),
      ),
    );
  }
}
