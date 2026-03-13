import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final double height;
  final double? width;
  final double borderRadius;
  final Color backgroundColor;
  final Color foregroundColor;
  final TextStyle? textStyle;

  const AppButton({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
    this.height = 58,
    this.width,
    this.borderRadius = 36,
    this.backgroundColor = const Color(0xFFFA4C75),
    this.foregroundColor = Colors.white,
    this.textStyle,
  }) : assert(label != null || icon != null, 'Provide label or icon');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: icon != null
            ? Icon(icon, size: 26)
            : Text(
                label!,
                style: textStyle,
              ),
      ),
    );
  }
}
