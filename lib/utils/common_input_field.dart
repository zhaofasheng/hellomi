import 'package:flutter/material.dart';

class CommonInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? iconData;
  final Widget? iconWidget;
  final TextInputType keyboardType;
  final Color hintTextColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double height;
  final double iconSize;
  final double fontSize;
  final bool obscureText;

  const CommonInputField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.iconData,
    this.iconWidget,
    this.keyboardType = TextInputType.text,
    this.hintTextColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFE0E0E0),
    this.borderRadius = 18.0,
    this.height = 50.0,
    this.iconSize = 20.0,
    this.fontSize = 16.0,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: [
          iconWidget ??
              (iconData != null
                  ? Icon(
                iconData,
                size: iconSize,
                color: hintTextColor,
              )
                  : const SizedBox()),

          SizedBox(width: 12),

          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: TextStyle(fontSize: fontSize),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: hintTextColor, fontSize: fontSize),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}