import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SleepPredictionWidget extends StatelessWidget {
  const SleepPredictionWidget({
    super.key,
    required this.message,
    this.buttonLabel = 'Lihat catatan tidur bayi',
    this.onTap,
  });

  final String message;
  final String buttonLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFF4D6D), width: 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ]
      ),
      
      child: Row(
        children: [
          Expanded(
            child: AutoSizeText(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              minFontSize: 12,
              style: const TextStyle(
                fontSize: 12,
                height: 1.3,
                color: Color(0xFF252525),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFFF4D6D), width: 1),
              ),
              child: Text(
                buttonLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFF4D6D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
