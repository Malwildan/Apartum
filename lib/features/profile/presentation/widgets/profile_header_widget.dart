import 'package:flutter/material.dart';

Widget HeaderSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Pink rounded rectangle background
        Container(
          height: 188,
          decoration: BoxDecoration(
            color: const Color(0xFFFF4D6D),
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
                // Circle shadow
                // Container(
                //   width: 134,
                //   height: 134,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.1),
                //         blurRadius: 0.1,
                //        // offset: const Offset(1, 1),
                //       ),
                //     ],
                //   ),
                // ),

                // Circle image placeholder
                Container(
                  width: 118,
                  height: 118,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 16),
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