import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'sleep_entry_model.dart';
import 'sleep_helpers.dart';
import 'sleep_time_widgets.dart';

class SleepEntryCardWidget extends StatelessWidget {
  final int index;
  final SleepEntry entry;
  final bool isToday;
  final Future<TimeOfDay?> Function() pickTime;
  final void Function(int index, TimeOfDay time) onStartChanged;
  final void Function(int index, TimeOfDay time) onEndChanged;
  final void Function(int index) onSubmit;
  final void Function(int index) onMarkAwake;

  const SleepEntryCardWidget({
    super.key,
    required this.index,
    required this.entry,
    required this.isToday,
    required this.pickTime,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onSubmit,
    required this.onMarkAwake,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Entri ${index + 1}',
            style: AppTypography.h3.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: StaticColor.surface,
              borderRadius: BorderRadius.circular(16.r),
              border:
                  Border.all(color: StaticColor.divider.withOpacity(0.5)),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.04),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: switch (entry.status) {
              EntryStatus.form => _buildFormEntry(context),
              EntryStatus.active => _buildActiveEntry(context),
              EntryStatus.completed => _buildCompletedEntry(),
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormEntry(BuildContext context) {
    final hasStart = entry.start != null;
    final hasEnd = entry.end != null;
    final canSubmit = hasStart;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('Jam mulai tidur', style: AppTypography.b3),
                  SizedBox(height: 8.h),
                  SleepTimeFieldWidget(
                    time: entry.start,
                    onTap: () async {
                      final t = await pickTime();
                      if (t != null) onStartChanged(index, t);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Text(' : ', style: AppTypography.h3),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('Jam bangun', style: AppTypography.b3),
                  SizedBox(height: 8.h),
                  SleepTimeFieldWidget(
                    time: entry.end,
                    onTap: () async {
                      final t = await pickTime();
                      if (t != null) onEndChanged(index, t);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        AppButton(
          label: hasStart && hasEnd
              ? 'Tambahkan entri'
              : 'Tambah waktu tidur bayi',
          onPressed: canSubmit ? () => onSubmit(index) : null,
          height: 40.h,
          borderRadius: 24.r,
          backgroundColor:
              canSubmit ? StaticColor.primaryPink : StaticColor.divider,
          foregroundColor:
              canSubmit ? StaticColor.surface : StaticColor.textMuted,
          leading: Icon(
            hasStart && hasEnd ? Icons.check : Icons.add_box_outlined,
            color: canSubmit ? StaticColor.surface : StaticColor.textMuted,
            size: 16.w,
          ),
          textStyle: AppTypography.button2.copyWith(
            color: canSubmit ? StaticColor.surface : StaticColor.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveEntry(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Jam mulai tidur', style: AppTypography.b3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(':', style: AppTypography.h3),
            ),
            SleepTimeChipWidget(time: entry.start!),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: StaticColor.sleepingStatusBackground,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              const Text('😴', style: TextStyle(fontSize: 16)),
              SizedBox(width: 8.w),
              Text(
                'Status: Bayi sedang tidur',
                style: AppTypography.b3
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        if (isToday) ...[
          SizedBox(height: 12.h),
          AppButton(
            label: 'Tandai bayi sudah bangun',
            onPressed: () => onMarkAwake(index),
            height: 40.h,
            borderRadius: 24.r,
            backgroundColor: StaticColor.primaryPink,
            foregroundColor: StaticColor.surface,
            textStyle: AppTypography.button2
                .copyWith(color: StaticColor.surface),
          ),
        ],
      ],
    );
  }

  Widget _buildCompletedEntry() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('Jam mulai tidur', style: AppTypography.b3),
                  SizedBox(height: 8.h),
                  SleepTimeChipWidget(time: entry.start!),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Text(' : ', style: AppTypography.h3),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('Jam bangun', style: AppTypography.b3),
                  SizedBox(height: 8.h),
                  SleepTimeChipWidget(time: entry.end!),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: StaticColor.completedStatusBackground,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: StaticColor.successGreen,
                size: 16.w,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Catatan disimpan. Durasi tidur bayi: ',
                    style: AppTypography.b4.copyWith(
                      color: StaticColor.completedStatusText,
                    ),
                    children: [
                      TextSpan(
                        text: SleepHelpers.formatDuration(
                          entry.start!.hour,
                          entry.start!.minute,
                          entry.end!.hour,
                          entry.end!.minute,
                        ),
                        style: AppTypography.b4.copyWith(
                          color: StaticColor.completedStatusText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: AppTypography.b4.copyWith(
                          color: StaticColor.completedStatusText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
