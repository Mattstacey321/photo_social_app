import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class ReactionButton extends StatefulWidget {
  final bool isReaction;
  final Function onTap;
  final IconData reactionIcon;
  final int reactionCount;

  const ReactionButton(
      {@required this.isReaction,
      @required this.onTap,
      this.reactionIcon = EvaIcons.heart,
      this.reactionCount = 0});
  @override
  _ReactionButtonState createState() => _ReactionButtonState();
}

class _ReactionButtonState extends State<ReactionButton> {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 30,
      isLiked: widget.isReaction,
      likeCountAnimationType: LikeCountAnimationType.all,
      circleColor:
          CircleColor(start: Colors.pink, end: Colors.pink.withOpacity(0.5)),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Colors.pink,
        dotSecondaryColor: Colors.pink.withOpacity(0.5),
      ),
      onTap: (isLiked) {
        setState(() {
          _isLiked = !_isLiked;
        });
        return widget.onTap(isLiked);
      },
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? widget.reactionIcon : widget.reactionIcon,
          color: isLiked ? Colors.pink : Colors.grey,
          size: 26,
        );
      },
      likeCount: widget.reactionCount,
      countBuilder: (int count, bool isLiked, String text) {
        return Text(
          text,
          style: TextStyle(
              color: isLiked ? Colors.pink : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 15),
        );
      },
      animationDuration: Duration(milliseconds: 250),
    );
  }
}
