import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/homepage/domain/entities/summary_status.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class StatusBannerWidget extends StatelessWidget {
  const StatusBannerWidget({
    super.key,
    required this.status,
    required this.onTap,
  });

  final SummaryStatus status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    late final Color bgColor;
    late final Color borderColor;
    late final Color iconBgColor;
    late final Color titleColor;
    late final Color subtitleColor;
    late final String title;
    late final String subtitle;

    switch (status) {
      case SummaryStatus.safe:
        bgColor = const Color(0xFFEAF4F4);
        borderColor = const Color(0xFF6EC6C7);
        iconBgColor = const Color(0xFF21494A);
        titleColor = const Color(0xFF2A3D3E);
        subtitleColor = const Color(0xFF2F3F40);
        title = 'Status Hari Ini: Aman';
        subtitle = 'Tidak ada tanda bahaya dari catatan terakhir';
        break;
      case SummaryStatus.warning:
        bgColor = const Color(0xFFFDF3E1);
        borderColor = const Color(0xFFF5B041);
        iconBgColor = const Color(0xFFE67E22);
        titleColor = const Color(0xFFB9770E);
        subtitleColor = const Color(0xFFB9770E);
        title = 'Status Hari Ini: Perlu perhatian';
        subtitle = 'Beberapa gejala perlu dipantau';
        break;
      case SummaryStatus.danger:
        bgColor = const Color(0xFFFDEEEF);
        borderColor = const Color(0xFFE74C3C);
        iconBgColor = const Color(0xFFC0392B);
        titleColor = const Color(0xFF922B21);
        subtitleColor = const Color(0xFF922B21);
        title = 'Status Hari Ini: Perlu tindakan segera';
        subtitle = 'Disarankan untuk segera berkonsultasi';
        break;
      case SummaryStatus.none:
        bgColor = const Color(0xFFF2F2F5);
        borderColor = const Color(0xFFCFCFD2);
        iconBgColor = const Color(0xFF8E8E9A);
        titleColor = const Color(0xFF5A5A6B);
        subtitleColor = const Color(0xFF8E8E9A);
        title = 'Status Hari Ini: Belum ada status';
        subtitle = 'Belum ada status untuk ditampilkan';
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                'i',
                style: AppTypography.detail.copyWith(
                  color: StaticColor.surface,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    title,
                    maxLines: 1,
                    style: AppTypography.h4.copyWith(
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  AutoSizeText(
                    subtitle,
                    maxLines: 2,
                    minFontSize: 8,
                    style: AppTypography.b4.copyWith(
                      color: subtitleColor,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            if (status != SummaryStatus.none) ...[  
              const SizedBox(width: 8),
              Row(
                children: [
                  Text(
                    'Lihat Detail',
                    style: AppTypography.h4.copyWith(
                      color: titleColor,
                      decoration: TextDecoration.underline,
                      decorationColor: titleColor,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(Icons.chevron_right, color: titleColor, size: 20),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
