import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:photo_social/style.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final String title;
  final int number;
  final double imageBorder;
  final double imageHeight;
  final double imageWidth;
  final Function onTap;
  const CustomNetworkImage(
      {@required this.url,
      this.imageBorder = 15,
      @required this.title,
      this.number = 0,
      @required this.onTap,
      @required this.imageHeight,
      @required this.imageWidth});

  @override
  Widget build(BuildContext context) {
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(imageBorder)),
                child: Icon(FeatherIcons.x_circle),
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
                      Text(
                        "${number.toString()} photos",
                        style: AppStyle.bannerNumber,
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
                      onTap: onTap,
                    ))),
          ],
        ),
      ),
    );
  }
}
