import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/sleep_daily_entity.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SleepWidget extends StatelessWidget {
  const SleepWidget({
    super.key,
    required this.todaySleep,
    this.onTap,
  });

  final SleepDailyEntity? todaySleep;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final sessionCount = todaySleep?.totalSessions ?? 0;
    final isFull = sessionCount >= 8;

    final String message;
    final String? buttonLabel;

    if (sessionCount == 0) {
      message = 'Belum ada catatan tidur bayi hari ini';
      buttonLabel = 'Tambah Tidur Bayi';
    } else if (isFull) {
      message = 'Entri tidur sudah penuh (8/8)';
      buttonLabel = null;
    } else {
      message = 'Anda telah melakukan $sessionCount entri hari ini';
      buttonLabel = 'Tambahkan entri';
    }

    final borderColor =
        isFull ? StaticColor.textMuted : StaticColor.primaryPink;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: StaticColor.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AutoSizeText(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              minFontSize: 12,
              style: AppTypography.b3Regular.copyWith(
                height: 1.3,
                color: isFull
                    ? StaticColor.textMuted
                    : StaticColor.textPrimary,
              ),
            ),
          ),
          if (buttonLabel != null) ...[
            const SizedBox(width: 8),
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: StaticColor.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: StaticColor.primaryPink,
                    width: 1,
                  ),
                ),
                child: Text(
                  buttonLabel,
                  style: AppTypography.b3.copyWith(
                    color: StaticColor.primaryPink,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
