import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/tidur_bayi/sleep_entry_card_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/tidur_bayi/sleep_entry_model.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/tidur_bayi/sleep_notice_widget.dart';

class SleepEntriesListWidget extends StatelessWidget {
  final List<SleepEntry> entries;
  final bool isToday;
  final int maxEntries;
  final VoidCallback onAddNew;
  final Future<TimeOfDay?> Function() pickTime;
  final void Function(int, TimeOfDay) onStartChanged;
  final void Function(int, TimeOfDay) onEndChanged;
  final void Function(int) onSubmit;
  final void Function(int) onMarkAwake;

  const SleepEntriesListWidget({
    super.key,
    required this.entries,
    required this.isToday,
    required this.maxEntries,
    required this.onAddNew,
    required this.pickTime,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onSubmit,
    required this.onMarkAwake,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: StaticColor.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: StaticColor.divider.withOpacity(0.5)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Catatan Tidur Bayi Hari Ini',
              style: AppTypography.h3.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 16.h),
            if (isToday) ...[
              SleepNoticeWidget(
                text: 'Ibu dapat menambahkan catatan waktu tidur bayi '
                    'sampai dengan maksimal $maxEntries kali entri',
              ),
              SizedBox(height: 12.h),
              Center(child: _buildAddNewButton()),
              SizedBox(height: 12.h),
              Center(
                child: Container(
                  width: 175.w,
                  height: 1.h,
                  color: StaticColor.divider,
                ),
              ),
            ],
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: entries.length,
                itemBuilder: (context, i) => SleepEntryCardWidget(
                  index: i,
                  entry: entries[i],
                  isToday: isToday,
                  pickTime: pickTime,
                  onStartChanged: onStartChanged,
                  onEndChanged: onEndChanged,
                  onSubmit: onSubmit,
                  onMarkAwake: onMarkAwake,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewButton() {
    final atMax = entries.length >= maxEntries;
    return AppButton(
      label: 'Tambahkan catatan',
      onPressed: atMax ? null : onAddNew,
      height: 25.h,
      width: 190.w,
      borderRadius: 24.r,
      backgroundColor: StaticColor.primaryPink,
      foregroundColor: StaticColor.surface,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      leading: Icon(
        Icons.add_circle_outline,
        color: StaticColor.surface,
        size: 16.w,
      ),
      textStyle: AppTypography.button2.copyWith(color: StaticColor.surface),
    );
  }
}
