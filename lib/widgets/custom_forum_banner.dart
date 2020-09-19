import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:photo_social/repository/forum_repository.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/widgets/custom_loading_state.dart';

class CustomForumBanner extends StatefulWidget {
  final String id;
  final String url;
  final String title;
  final int number;
  final double imageBorder;
  final double imageHeight;
  final double imageWidth;
  final String blurHash;
  final Function onTap;
  const CustomForumBanner(
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
  _CustomForumBannerState createState() => _CustomForumBannerState();
}

class _CustomForumBannerState extends State<CustomForumBanner> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  @override
  Widget build(BuildContext context) {
    Widget defaultPlaceHolder = widget.blurHash == ""
        ? PlaceHolderWidget(
            imageBorder: widget.imageBorder,
            imageHeight: widget.imageHeight,
            imageWidth: widget.imageWidth,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(widget.imageBorder),
            child: BlurHash(hash: "r${widget.blurHash}"),
          );
    Widget defaultErrorHolder = ErrorHolderWidget(
      imageBorder: widget.imageBorder,
      imageHeight: widget.imageHeight,
      imageWidth: widget.imageWidth,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(widget.imageBorder),
        onTap: widget.onTap,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: widget.url,
              placeholder: (context, url) => defaultPlaceHolder,
              errorWidget: (context, url, error) => defaultErrorHolder,
              placeholderFadeInDuration: Duration(milliseconds: 300),
              imageBuilder: (context, imageProvider) => Container(
                height: widget.imageHeight,
                width: widget.imageWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.imageBorder),
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
                        widget.title,
                        style: AppStyle.bannerTitle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder(
                          future: _memoizer.runOnce(() =>
                              ForumRepository.countForumPost(
                                  forumId: widget.id)),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
