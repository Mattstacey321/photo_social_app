import 'package:bot_toast/bot_toast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/constraint/app_controllers.dart';
import 'package:photo_social/modules/theme/theme_controller.dart';
import 'package:photo_social/src/bottom_sheet/index.dart';
import 'package:photo_social/widgets/index.dart';

import '../../bookmark/bookmark_controller.dart';

class BookmarkButton extends StatefulWidget {
  final String postId;
  final String forumId;
  final bool isBookmarked;
  final String postFirstImage;
  BookmarkButton(
      {this.forumId,
      this.postId,
      this.isBookmarked = false,
      this.postFirstImage});
  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TextEditingController collectionCtrl = TextEditingController();
  LoadingButtonController buttonController = LoadingButtonController();
  AnimationController animationController;
  Animation animation;

  bool get isBookmark => widget.isBookmarked;
  bool _isBookmark = false;

  @override
  void initState() {
    super.initState();
    _isBookmark = isBookmark;
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 200), value: 1.0);
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Curves.easeIn,
        parent: animationController,
        reverseCurve: Curves.easeOut))
      ..addListener(() {
        setState(() {
          animationController.forward();
        });
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void unclickBookmark() {
    setState(() {
      _isBookmark = false;
      animationController.reset();
    });
  }

  void keepBookmarkButtonState() {
    setState(() {
      _isBookmark = false;
      animationController.reverse();
    });
  }

  void changeBookmarkButtonState() {
    setState(() {
      _isBookmark = true;
      animationController.reset();
    });
  }

  void undoBookmark() {
    showSelectedCollection("/modify");
    /* BookmarkController.to.unBookmarkPost(postId: widget.postId).then((value) {
      unclickBookmark();
      BotToast.showText(text: "UnBookmark");
    }).catchError((err) {
      return;
    });*/
  }

  void showSelectedCollection(String route) async {
    var result = Get.bottomSheet(
      CollectionAction(namedRoute: route),
      backgroundColor: ThemeController.to.colorScheme,
      elevation: 1,
      isDismissible: true,
      persistent: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
    result.then((value) {
      // on close bottomsheet
      if (value == null) {
        if (mounted) keepBookmarkButtonState();
        BookmarkController.to.collectionSelected.clear();
      } else {
        if (mounted) changeBookmarkButtonState();
        BotToast.showText(text: "Bookmark");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () async {
        if (_isBookmark == true) {
          undoBookmark();
        } else {
          BookmarkController.to.setPostInfo(
            id: widget.postId,
            url: widget.postFirstImage,
          );
          // check have any collection yet ?
          showSelectedCollection(CollectionController.to.collectionLength > 0
              ? "/existing"
              : "/new");
        }
      },
      child: ScaleTransition(
        scale: animationController,
        child: Icon(_isBookmark ? EvaIcons.bookmark : EvaIcons.bookmarkOutline),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
