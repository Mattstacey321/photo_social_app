import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/index.dart';
import '../../../global_widgets/input/custom_input.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isClick = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.requestFocus();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          _isClick = false;
        });
      }
      //debugPrint('${focusNode.hasFocus}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      child: AnimatedSwitcher(
        duration: 500.milliseconds,
        child: _isClick
            ? AnimatedContainer(
                duration: 200.milliseconds,
                height: 40,
                width: Get.width / 4,
                child: CustomInput(
                  focusNode: focusNode,
                  controller: TextEditingController(),
                  hintText: "Search term",
                  //prefix: Icon(EvaIcons.search),
                  //suffix: Icon(EvaIcons.close),
                ),
              )
            : CircleIcon(
                onTap: () {
                  setState(() {
                    _isClick = true;
                  });
                },
                icon: Icon(EvaIcons.search),
                tooltip: "Search",
                showToolTip: true,
              ),
      ),
    );
  }
}
