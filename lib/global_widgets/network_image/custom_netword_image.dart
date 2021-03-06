import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import 'image_loading_state.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final double imageBorder;
  final double imageHeight;
  final double imageWidth;
  final String blurHash;
  final Function onTap;
  final Function onLongTap;
  final BoxFit fit;
  const CustomNetworkImage(
      {@required this.url,
      this.imageBorder = 15,
      this.blurHash = "",
      this.fit = BoxFit.cover,
      @required this.onTap,
      this.onLongTap,
      @required this.imageHeight,
      @required this.imageWidth});

  @override
  Widget build(BuildContext context) {
    Widget defaultPlaceHolder;
    blurHash == ""
        ? defaultPlaceHolder = PlaceHolderWidget(
            imageBorder: imageBorder,
            imageHeight: imageHeight,
            imageWidth: imageWidth,
          )
        : defaultPlaceHolder = ClipRRect(
            borderRadius: BorderRadius.circular(imageBorder),
            child: BlurHash(hash: "$blurHash"),
          );
    Widget defaultErrorHolder = ErrorHolderWidget(
      imageBorder: imageBorder,
      imageHeight: imageHeight,
      imageWidth: imageWidth,
    );

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(imageBorder),
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(imageBorder),
        onTap: onTap,
        onLongPress: onLongTap,
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
                    alignment: (imageHeight < imageWidth) ? Alignment.center : Alignment.topCenter,
                    fit: fit,
                  ),
                ),
              ),
            ),

            // must add here to give splash effect
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(imageBorder),
                child: InkWell(
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(imageBorder),
                  onTap: onTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
