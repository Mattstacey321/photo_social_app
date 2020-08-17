import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String url;
  final double size;
  final String toolTip;
  final Function onTap;
  CustomAvatar({@required this.url, @required this.onTap, this.toolTip = "", this.size});
  @override
  Widget build(BuildContext context) {
    double avatarBorder = 15;
    return Material(
      color: Colors.transparent,
      child: Tooltip(
        message: toolTip,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(avatarBorder),
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
                    borderRadius: BorderRadius.circular(avatarBorder),
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
                    borderRadius: BorderRadius.circular(avatarBorder),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(avatarBorder),
                  border: Border.all(color: Colors.black,width: 1)
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(avatarBorder),
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
