import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final double height;
  final double borderRadius;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.height = 58,
    this.borderRadius = 24,
    this.textStyle,
    this.hintStyle,
    this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        style: textStyle,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: suffixIcon,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Color(0xFF2D2D2D), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Color(0xFF2D2D2D), width: 1.2),
          ),
        ),
      ),
    );
  }
}
