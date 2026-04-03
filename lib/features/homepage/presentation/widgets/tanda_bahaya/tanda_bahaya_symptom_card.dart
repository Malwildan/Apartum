import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/features/homepage/presentation/widgets/tanda_bahaya/tanda_bahaya_date_helper.dart';
import 'package:apartum/features/homepage/presentation/widgets/tanda_bahaya/tanda_bahaya_safe_card.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TandaBahayaSymptomCard extends StatefulWidget {
  const TandaBahayaSymptomCard({super.key, required this.symptom});

  final SymptomEntity symptom;

  @override
  State<TandaBahayaSymptomCard> createState() => _TandaBahayaSymptomCardState();
}

class _TandaBahayaSymptomCardState extends State<TandaBahayaSymptomCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final alert = widget.symptom.alert;
    final isSafe = alert == null || alert.level == 'safe';

    if (isSafe) {
      return TandaBahayaSafeCard(dateStr: widget.symptom.date);
    }

    final isDanger = alert.level == 'danger';
    final issues = alert.issues;

    final Color bg = isDanger
        ? const Color(0xFFFEEBEC)
        : const Color(0xFFFEF3E2);
    final Color borderColor = isDanger
        ? const Color(0xFFF5C2C4)
        : const Color(0xFFFDDDAA);
    final Color iconBg = isDanger
        ? const Color(0xFFFEE2E2)
        : const Color(0xFFFEF9C3);
    final Color iconColor = isDanger
        ? StaticColor.errorRed
        : StaticColor.warningYellow;

    final String title = issues.length == 1
        ? issues[0].disease
        : isDanger
            ? 'Kondisi yang perlu perhatian segera'
            : 'Beberapa gejala perlu dipantau';

    final String subtitle = isDanger
        ? 'Kami memahami bahwa kondisi ini bisa membuat ibu khawatir. Langkah terbaik adalah segera berkonsultasi.'
        : 'Ibu disarankan untuk berkonsultasi dengan tenaga medis jika gejala terus berlanjut.';

    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36.r,
                    height: 36.r,
                    decoration: BoxDecoration(
                      color: iconBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: iconColor,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography.b1.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          subtitle,
                          style: AppTypography.b3.copyWith(
                            color: StaticColor.textPrimary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: StaticColor.textMuted,
                    size: 22.sp,
                  ),
                ],
              ),
            ),
           
            if (_expanded && issues.isNotEmpty) ...[
              Divider(
                height: 1,
                thickness: 1,
                color: borderColor,
                indent: 14.w,
                endIndent: 14.w,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gejala yang memicu peringatan:',
                      style: AppTypography.b3.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    ...issues.expand(
                      (issue) => issue.symptoms.map(
                        (s) => Padding(
                          padding: EdgeInsets.only(bottom: 3.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 5.h, right: 6.w),
                                child: Container(
                                  width: 5.r,
                                  height: 5.r,
                                  decoration: BoxDecoration(
                                    color: StaticColor.textPrimary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(s, style: AppTypography.b3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            // Date
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 10.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  formatTandaBahayaDate(widget.symptom.date),
                  style: AppTypography.b4.copyWith(
                    color: StaticColor.textMuted,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
