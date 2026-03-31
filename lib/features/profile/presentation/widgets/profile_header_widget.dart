import 'package:apartum/core/theme/app_static_color.dart';
import 'package:flutter/material.dart';

Widget HeaderSection() {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        height: 188,
        decoration: BoxDecoration(
          color: StaticColor.primaryPink,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(88),
            bottomRight: Radius.circular(88),
          ),
        ),
      ),

      Positioned(
        left: 0,
        right: 0,
        bottom: -60,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 118,
                height: 118,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: StaticColor.surface,
                  border: Border.all(color: StaticColor.surface, width: 16),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/onboarding1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
