import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/features/riwayat_catatan/presentation/riwayat_catatan_answer_data.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_radio_widget.dart';
import 'package:flutter/material.dart';

class Bagian1Widget extends StatefulWidget {
  final Function(Bagian1AnswerData) onNext;

  const Bagian1Widget({super.key, required this.onNext});

  @override
  State<Bagian1Widget> createState() => _Bagian1WidgetState();
}

class _Bagian1WidgetState extends State<Bagian1Widget> {
  String? q1Answer;
  String? q2Answer;
  String? q3Answer;
  String? q4Answer;

  bool get _isAllAnswered =>
      q1Answer != null &&
      q2Answer != null &&
      q3Answer != null &&
      q4Answer != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: StaticColor.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: StaticColor.divider.withValues(alpha: 0.5)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Fixed Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bagian 1 – Pendarahan',
                  style: AppTypography.h3.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  'Catat semua gejala dan kondisi yang terjadi hari ini',
                  style: AppTypography.b3.copyWith(
                    color: StaticColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const LinearProgressIndicator(
                      value: 0.33,
                      backgroundColor: Color(0xFFE5E5E5),
                      color: StaticColor.primaryPink,
                      minHeight: 6,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Langkah 1 dari 3',
                    style: AppTypography.b4.copyWith(
                      color: StaticColor.primaryPink,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                QuestionRadioWidget(
                  title: 'Berapa pembalut yang dipakai?',
                  subtitle: '*wajib diisi, pilih salah satu',
                  options: const [
                    '1 pembalut / 24 jam',
                    '1 pembalut / 6 jam',
                    '1 pembalut / 2 jam',
                    'Lebih cepat dari itu',
                  ],
                  selectedOption: q1Answer,
                  onChanged: (value) {
                    setState(() => q1Answer = value);
                  },
                ),
                QuestionRadioWidget(
                  title: 'Warna darah yang keluar',
                  subtitle: '*wajib diisi, pilih salah satu',
                  options: const ['Merah tua', 'Merah normal', 'Merah terang'],
                  selectedOption: q2Answer,
                  onChanged: (value) {
                    setState(() => q2Answer = value);
                  },
                ),
                QuestionRadioWidget(
                  title: 'Besar ukuran gumpalan darah',
                  subtitle: '*wajib diisi, pilih salah satu',
                  options: const [
                    'Tidak ada',
                    'Koin kecil',
                    'Koin besar',
                    'Bola pingpong',
                  ],
                  selectedOption: q3Answer,
                  onChanged: (value) {
                    setState(() => q3Answer = value);
                  },
                ),
                QuestionRadioWidget(
                  title: 'Bau cairan dari jalan lahir',
                  subtitle: '*wajib diisi, pilih salah satu',
                  options: const [
                    'Tidak berbau',
                    'Berbau sedikit',
                    'Berbau menyengat',
                  ],
                  selectedOption: q4Answer,
                  onChanged: (value) {
                    setState(() => q4Answer = value);
                  },
                ),
              ],
            ),
          ),

          // Fixed Bottom Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: AppButton(
                label: 'Lanjutkan',
                trailing: const Icon(Icons.arrow_forward),
                onPressed: _isAllAnswered
                    ? () => widget.onNext(Bagian1AnswerData(
                          pembalut: q1Answer,
                          warnaDarah: q2Answer,
                          gumpalan: q3Answer,
                          bau: q4Answer,
                        ))
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
