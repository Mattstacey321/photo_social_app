import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CloseDialogButton extends StatefulWidget {
  final Function() onTap;
  CloseDialogButton({@required this.onTap});
  @override
  _CloseDialogButtonState createState() => _CloseDialogButtonState();
}

class _CloseDialogButtonState extends State<CloseDialogButton> {
  bool isEnter = false;

  void onEnter() {
    setState(() {
      isEnter = true;
    });
  }

  void onExit() {
    setState(() {
      isEnter = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => onEnter(),
      onExit: (event) => onExit(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Icon(
          Icons.close,
          color: isEnter ? Colors.grey : Colors.grey[350],
          size: 20,
        ),
      ),
    );
  }
}