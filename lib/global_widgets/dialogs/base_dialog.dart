import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/utils/keyboard_shortcut.dart';
import '../../src/buttons/close_dialog_button.dart';
import '../index.dart';

Future<void> baseDialog({
  @required double height,
  @required double width,
  @required String title,
  @required List<Widget> content,
  Function onExit,
  Function onBack,
  @required Widget confirmWidget,
  Widget closeWidget,
  MainAxisAlignment childAlignment = MainAxisAlignment.spaceBetween,
  bool barrierDismissible = true,
  String barrierLabel = "",
  double padding = 10,
}) async {
  Widget _closeWidget = TextButton(
    onPressed: onExit == null ? () => Get.back() : () {},
    child: Text("Cancel"),
  );
  return Get.generalDialog(
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) {
      return FocusableActionDetector(
        autofocus: true,
        shortcuts: {escapeKeySet: CloseDialogIntent()},
        actions: {CloseDialogIntent: CallbackAction(onInvoke: (e) => Get.back())},
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: AnimatedContainer(
              duration: 1.seconds,
              height: height,
              width: width,
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: SlideTransition(
                position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(CurvedAnimation(
                    parent: animation, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
                child: Column(
                  mainAxisAlignment: childAlignment,
                  children: <Widget>[
                    // titlebar
                    Container(
                      height: 30,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      title,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  right: 5,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        onBack == null
                                            ? const SizedBox()
                                            : Positioned(
                                                child: CircleIcon(
                                                    onTap: onBack,
                                                    icon: Icon(EvaIcons.arrowBack),
                                                    tooltip: "Back"),
                                              ),
                                        CloseDialogButton(
                                          onTap: () => Get.back(),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    //content
                    Flexible(
                        child: Column(
                      children: <Widget>[
                        for (var item in content) item,
                      ],
                    )),
                    const SizedBox(height: 20),
                    //exit, confirm button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [_closeWidget, confirmWidget],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Transform.translate(
        offset: Offset(animation.value, animation.value * 15),
        child: Opacity(opacity: animation.value, child: child),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
  );
}
