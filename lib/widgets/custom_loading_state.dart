import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class PlaceHolderWidget extends StatelessWidget {
  final double imageHeight;
  final double imageWidth;
  final double imageBorder;
  const PlaceHolderWidget({this.imageHeight, this.imageWidth, this.imageBorder});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight,
      width: imageWidth,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(imageBorder),
      ),
    );
  }
}

class ErrorHolderWidget extends StatelessWidget {
  final double imageHeight;
  final double imageWidth;
  final double imageBorder;
  const ErrorHolderWidget({this.imageHeight, this.imageWidth, this.imageBorder});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight,
      width: imageWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(imageBorder)),
      child: Icon(FeatherIcons.x_circle),
    );
  }
}
