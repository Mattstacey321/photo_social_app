import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool showPassword;
  final Function(String) onChange;
  final Widget prefix;
  final Widget suffix;
  const CustomInput(
      {@required this.controller,
      @required this.hintText,
      this.prefix,
      this.suffix,
      this.onChange,
      this.showPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: showPassword,
        onChanged: onChange,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          fillColor: Colors.grey.withOpacity(0.2),
          filled: true,
          prefixIcon: prefix,
          suffixIcon: suffix,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.grey[400]),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
