import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String url;
  final double size;
  final String toolTip;
  final Function onTap;
  final double borderRadius;
  final bool enableElevation;
  CustomAvatar(
      {@required this.url,
      @required this.onTap,
      this.toolTip = "",
      this.size,
      this.enableElevation = false,
      this.borderRadius = 15});
  @override
  Widget build(BuildContext context) {
    //double avatarBorder = 15;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: enableElevation
              ? [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: Offset(1, 1),
                      spreadRadius: 2)
                ]
              : []),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: url,
                placeholder: (context, url) => Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                placeholderFadeInDuration: Duration(milliseconds: 300),
                errorWidget: (context, url, error) => Container(
                  height: size,
                  width: size,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(1000)),
                  child: Icon(FeatherIcons.x_circle),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(borderRadius),
                    splashColor: Colors.grey.withOpacity(0.2),
                    onTap: onTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
