import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final double height;
  final double width;
  final bool autoFocus;
  final String hintText;
  final bool showPassword;
  final Function(String) onChange;
  final Widget prefix;
  final Widget suffix;
  const CustomInput(
      {@required this.controller,
      @required this.hintText,
      this.focusNode,
      this.autoFocus = true,
      this.height = 50,
      this.width,
      this.prefix,
      this.suffix,
      this.onChange,
      this.showPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextFormField(
        autofocus: autoFocus,
        focusNode: focusNode,
        controller: controller,
        obscureText: showPassword,
        onChanged: onChange,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          fillColor: Colors.grey.withOpacity(0.2),
          filled: true,
          prefix: prefix,
          suffix: suffix,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.grey[400]),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
