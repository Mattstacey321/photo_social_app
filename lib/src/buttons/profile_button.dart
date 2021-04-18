import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/profile/controllers/profile_controller.dart';

class ProfileButton extends GetView<ProfileController> {
  final VoidCallback onTap;
  ProfileButton({@required this.onTap});
  @override
  Widget build(BuildContext context) {
    const avatarSize = 30.0;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: controller.isGuest
            ? Container(
                height: avatarSize,
                width: avatarSize,
                color: Colors.grey,
              )
            : controller.avatar == null
                ? Container(
                    height: avatarSize,
                    width: avatarSize,
                    color: Colors.grey,
                  )
                : Image.network(
                    controller.avatar,
                    height: avatarSize,
                    width: avatarSize,
                    errorBuilder: (context, url, error) => Container(
                      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                      height: avatarSize,
                      width: avatarSize,
                    ),
                  ),
      ),
    );
  }
}
