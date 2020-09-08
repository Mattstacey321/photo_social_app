import 'dart:math' as math;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class CustomSVG extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mainColor = 0xff303f9f; //0xffBCAAEA;
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        children: [
          Positioned(
            right: -8,
            bottom: -8,
            child: Transform.rotate(
              angle: -math.pi / 12.0,
              child: Icon(
                EvaIcons.image,
                size: 40,
                color: Color(mainColor),
              ),
            ),
          ),
          Positioned(
            right: 32,
            bottom: 30,
            child: Icon(
              EvaIcons.pricetagsOutline,
              size: 30,
              color: Color(mainColor),
            ),
          ),
          Positioned(
            right: 42,
            bottom: -10,
            child: Icon(
              EvaIcons.radioButtonOffOutline,
              size: 30,
              color: Color(mainColor),
            ),
          ),
        ],
      ),
    );
  }
}
