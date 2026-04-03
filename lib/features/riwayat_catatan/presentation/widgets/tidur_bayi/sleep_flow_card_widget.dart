import 'package:apartum/features/riwayat_catatan/presentation/widgets/tidur_bayi/sleep_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:apartum/core/global_widget/status_card_widget.dart';

class SleepFlowCardWidget extends StatelessWidget {
  final SleepFlowPhase phase;
  final String? errorMessage;
  final VoidCallback onDone;

  const SleepFlowCardWidget({
    super.key,
    required this.phase,
    required this.onDone,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (phase == SleepFlowPhase.saving) {
      return const Center(child: StatusCardWidget(status: CardStatus.loading));
    }

    if (phase == SleepFlowPhase.success) {
      return Center(
        child: StatusCardWidget(
          status: CardStatus.success,
          successTitle: 'Catatan tidur berhasil disimpan',
          successSubtitle: 'Data waktu tidur bayi telah tersimpan.',
          successButtonLabel: 'Lihat riwayat pencatatan',
          onSuccess: onDone,
        ),
      );
    }

    return Center(
      child: StatusCardWidget(
        status: CardStatus.error,
        errorTitle: 'Gagal menyimpan catatan tidur',
        errorSubtitle: errorMessage ?? 'Terjadi kesalahan. Silahkan coba lagi.',
        errorButtonLabel: 'Lihat riwayat pencatatan',
        onError: onDone,
      ),
    );
  }
}
