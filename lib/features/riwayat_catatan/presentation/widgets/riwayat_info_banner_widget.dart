import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';

enum RiwayatInfoBannerVariant { defaultBanner, danger, warning, done }

class RiwayatInfoBannerWidget extends StatelessWidget {
  const RiwayatInfoBannerWidget({
    super.key,
    required this.variant,
    this.title,
    this.description,
  });

  final RiwayatInfoBannerVariant variant;
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    late final Color bgColor;
    late final Color borderColor;
    late final Color iconBgColor;
    late final Color textColor;
    late final String defaultTitle;
    late final String defaultDescription;

    switch (variant) {
      case RiwayatInfoBannerVariant.defaultBanner:
        bgColor = StaticColor.bannerDefaultBackground;
        borderColor = StaticColor.bannerDefaultBorder;
        iconBgColor = StaticColor.bannerDefaultIcon;
        textColor = StaticColor.bannerDefaultText;
        defaultTitle = 'Anda belum mencatat gejala hari ini, yuk segera mencatat!';
        defaultDescription =
            'Catatan ini membantu memantau kesehatan Ibu selama masa pemulihan. Tidak ada jawaban yang salah dan pilih kondisi yang paling mendekati hari ini.';
        break;
      case RiwayatInfoBannerVariant.warning:
        bgColor = StaticColor.bannerWarningBackground;
        borderColor = StaticColor.bannerWarningBorder;
        iconBgColor = StaticColor.bannerWarningIcon;
        textColor = StaticColor.bannerWarningText;
        defaultTitle = 'Status Hari Ini: Perlu perhatian';
        defaultDescription = 'Beberapa gejala perlu dipantau';
        break;
      case RiwayatInfoBannerVariant.danger:
        bgColor = StaticColor.bannerDangerBackground;
        borderColor = StaticColor.bannerDangerBorder;
        iconBgColor = StaticColor.bannerDangerIcon;
        textColor = StaticColor.bannerDangerText;
        defaultTitle = 'Status Hari Ini: Perlu tindakan segera';
        defaultDescription = 'Disarankan untuk segera berkonsultasi';
        break;
      case RiwayatInfoBannerVariant.done:
        bgColor = StaticColor.bannerDoneBackground;
        borderColor = StaticColor.bannerDoneBorder;
        iconBgColor = StaticColor.bannerDoneIcon;
        textColor = StaticColor.bannerDoneText;
        defaultTitle = 'Anda telah menyelesaikan semua pencatatan.\nAnda dapat melakukan perubahan';
        defaultDescription = '';
        break;
    }

    final displayTitle = title ?? defaultTitle;
    final displayDescription = description ?? defaultDescription;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
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
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: variant == RiwayatInfoBannerVariant.done
                ? Icon(Icons.check, color: StaticColor.surface, size: 13.w)
                : Text(
                    'i',
                    textAlign: TextAlign.center,
                    style: AppTypography.detail.copyWith(
                      color: StaticColor.surface,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                    ),
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  displayTitle,
                  maxLines: 1,
                  style: AppTypography.h4.copyWith(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                variant == RiwayatInfoBannerVariant.done
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          const SizedBox(height: 2),
                          AutoSizeText(
                        displayDescription,
                        maxLines: 2,
                        minFontSize: 8,
                        style: AppTypography.b4.copyWith(
                          color: textColor,
                          height: 1.3,
                        ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}