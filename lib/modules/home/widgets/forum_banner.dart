import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:photo_social/models/forum_model.dart';
import 'package:photo_social/themes/app_styles.dart';
import 'package:photo_social/widgets/index.dart';

class ForumBanner extends StatefulWidget {
  final ForumModel forum;
  final Function onTap;
  final double height;
  final double width;
  final double radius;
  const ForumBanner({
    @required this.forum,
    @required this.height,
    @required this.width,
    this.radius = 10,
    @required this.onTap,
  });

  @override
  _ForumBannerState createState() => _ForumBannerState();
}

class _ForumBannerState extends State<ForumBanner> {
  double get width => widget.width;
  double get height => widget.height;
  double get radius => widget.radius;
  String get bannerBG => widget.forum.banner;
  String get totalPost => widget.forum.totalPost.toString();
  String get forumName => widget.forum.name;
  String get blurHash => "";

  @override
  Widget build(BuildContext context) {
    Widget defaultPlaceHolder = blurHash == ""
        ? PlaceHolderWidget(
            imageBorder: radius,
            imageHeight: height,
            imageWidth: width,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: BlurHash(hash: "r$blurHash"),
          );
    Widget defaultErrorHolder = ErrorHolderWidget(
      imageBorder: radius,
      imageHeight: height,
      imageWidth: width,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(radius),
        onTap: widget.onTap,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: bannerBG,
              placeholder: (context, url) => defaultPlaceHolder,
              errorWidget: (context, url, error) => defaultErrorHolder,
              placeholderFadeInDuration: Duration(milliseconds: 300),
              imageBuilder: (context, imageProvider) => Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
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
                        forumName,
                        style: AppStyles.bannerTitle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "$totalPost post",
                        style: AppStyles.bannerNumber,
                      )
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
                  onTap: widget.onTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
