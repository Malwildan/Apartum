import 'package:auto_size_text/auto_size_text.dart';
import 'package:apartum/core/global_widget/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyCheckWidget extends StatelessWidget {
  const DailyCheckWidget({
    super.key,
    required this.message,
    this.buttonLabel = 'Catat Kondisi Hari Ini',
    this.onTap,
  });

  final String message;
  final String buttonLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color.fromARGB(255, 255, 211, 219), Color(0xFFFFFFFF)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFF4D6D), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            message,
            textAlign: TextAlign.center,
            maxLines: 2,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              height: 1.25,
              color: Color(0xFF1F1F1F),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          AppButton(
            label: buttonLabel,
            onPressed: () {},
            height: 44,
            borderRadius: 24,
            backgroundColor: const Color(0xFFFF4D6D),
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
