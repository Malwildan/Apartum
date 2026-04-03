import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/global_widget/status_card_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_state.dart';

enum SaveFlowPhase { none, saving, saved, alertResult }

class GejalaHelpers {
  static String formatDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}

class SaveFlowCard extends StatelessWidget {
  final SaveFlowPhase phase;
  final SymptomState state;
  final VoidCallback onResultDismiss;
  final VoidCallback onSavedContinue;

  const SaveFlowCard({
    super.key,
    required this.phase,
    required this.state,
    required this.onResultDismiss,
    required this.onSavedContinue,
  });

  @override
  Widget build(BuildContext context) {
    if (phase == SaveFlowPhase.saving) {
      return const Center(child: StatusCardWidget(status: CardStatus.loading));
    }

    if (phase == SaveFlowPhase.saved) {
      return Center(
        child: StatusCardWidget(
          status: CardStatus.success,
          successTitle: 'Data berhasil disimpan',
          successSubtitle: 'Lihat hasil analisis gejala yang Anda catat.',
          successButtonLabel: 'Lihat Hasil Analisis',
          onSuccess: onSavedContinue,
        ),
      );
    }

    if (phase == SaveFlowPhase.alertResult) {
      final alert = state.symptomDetail?.alert;
      if (alert == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => onResultDismiss());
        return const SizedBox.shrink();
      }

      final issues = alert.issues
          .map((i) => AlertIssueData(disease: i.disease, symptoms: i.symptoms))
          .toList();

      final cardStatus = switch (alert.level) {
        'safe' => CardStatus.safe,
        'warning' => CardStatus.warning,
        'danger' => CardStatus.danger,
        _ => CardStatus.safe,
      };

      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Center(
          child: StatusCardWidget(
            status: cardStatus,
            alertIssues: issues,
            onSuccess: onResultDismiss,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class NotFoundSymptomWidget extends StatelessWidget {
  final DateTime selectedDate;

  const NotFoundSymptomWidget({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        '${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}';

    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFE8E8E8)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.event_note_rounded,
              size: 40.w,
              color: const Color(0xFF9CA3AF),
            ),
            SizedBox(height: 16.h),
            Text(
              'Data gejala tidak ditemukan',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Belum ada riwayat gejala yang tersimpan untuk tanggal $formattedDate.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF6B7280),
                    height: 1.4,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
