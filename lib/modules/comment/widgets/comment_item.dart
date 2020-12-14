import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/constraint.dart';
import 'package:photo_social/modules/account/account_controller.dart';
import 'package:photo_social/themes/app_fonts.dart';
import 'package:photo_social/models/comment_model.dart';
import 'package:photo_social/utils/time_utils.dart';
import 'package:photo_social/widgets/network_image/custom_netword_image.dart';

import 'index.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onCommentSetting;
  final VoidCallback onLiked;
  final VoidCallback onReply;
  const CommentItem(
      {@required this.comment,
      this.onCommentSetting,
      this.onLiked,
      this.onReply});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CustomNetworkImage(
                  url: comment.user.avatar ?? AppConstraints.defaultAvatar,
                  imageBorder: 10,
                  imageHeight: 35,
                  imageWidth: 35,
                  onTap: () {},
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 8,
                child: Container(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: AppFonts.gSansRegular,
                      ),
                      children: [
                        TextSpan(
                          text: comment.comment,
                          style: TextStyle(fontSize: 15),
                        ),
                        TextSpan(
                          text: " • ",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        TextSpan(
                          text: comment.user.name ?? "...",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        TextSpan(
                          text: " • ",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        TextSpan(
                          text: getCurrentTime(
                            time: comment.createdTime.toString(),
                          ),
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          height: 180,
                          width: Get.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child:
                              comment.user.name == AccountController.to.userName
                                  ? UserMoreComment()
                                  : OtherMoreComment(
                                      userName: comment.user.name,
                                    ),
                        ),
                        elevation: 1,
                        isDismissible: true,
                        backgroundColor: Colors.white,
                        enterBottomSheetDuration: Duration(milliseconds: 150),
                        exitBottomSheetDuration: Duration(milliseconds: 150),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        EvaIcons.moreHorizotnal,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 45,
              ),
              InkWell(
                onTap: onLiked,
                child: Text(
                  "Like",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: onReply,
                child: Text(
                  "Reply",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
