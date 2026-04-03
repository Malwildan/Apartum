import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/riwayat_catatan_answer_data.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_radio_widget.dart';

class Bagian1Widget extends StatefulWidget {
  final Function(Bagian1AnswerData) onNext;

  const Bagian1Widget({super.key, required this.onNext});

  @override
  State<Bagian1Widget> createState() => _Bagian1WidgetState();
}

class _Bagian1WidgetState extends State<Bagian1Widget> {
  String? _q1Answer;
  String? _q2Answer;
  String? _q3Answer;
  String? _q4Answer;

  bool get _isAllAnswered =>
      _q1Answer != null &&
      _q2Answer != null &&
      _q3Answer != null &&
      _q4Answer != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: StaticColor.surface,
        borderRadius: BorderRadius.circular(20.r),
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
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bagian 1 – Pendarahan',
                  style: AppTypography.h3.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4.h),
                AutoSizeText(
                  maxLines: 1,
                  'Catat semua gejala dan kondisi yang terjadi hari ini',
                  style: AppTypography.b3.copyWith(
                    color: StaticColor.textPrimary,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: 0.33,
                      backgroundColor: const Color(0xFFE5E5E5),
                      color: StaticColor.primaryPink,
                      minHeight: 6.h,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
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
              padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                  selectedOption: _q1Answer,
                  onChanged: (value) => setState(() => _q1Answer = value),
                ),
                QuestionRadioWidget(
                  title: 'Warna darah yang keluar',
                  subtitle: '*wajib diisi, pilih salah satu',
                  options: const ['Merah tua', 'Merah normal', 'Merah terang'],
                  selectedOption: _q2Answer,
                  onChanged: (value) => setState(() => _q2Answer = value),
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
                  selectedOption: _q3Answer,
                  onChanged: (value) => setState(() => _q3Answer = value),
                ),
                QuestionRadioWidget(
                  title: 'Bau cairan dari jalan lahir',
                  subtitle: '*wajib diisi, pilih salah satu',
                  options: const [
                    'Tidak berbau',
                    'Berbau sedikit',
                    'Berbau menyengat',
                  ],
                  selectedOption: _q4Answer,
                  onChanged: (value) => setState(() => _q4Answer = value),
                ),
              ],
            ),
          ),

          // Fixed Bottom Button
          Padding(
            padding: EdgeInsets.all(20.w),
            child: SizedBox(
              width: double.infinity,
              child: AppButton(
                label: 'Lanjutkan',
                trailing: const Icon(Icons.arrow_forward),
                onPressed: _isAllAnswered
                    ? () => widget.onNext(Bagian1AnswerData(
                          pembalut: _q1Answer,
                          warnaDarah: _q2Answer,
                          gumpalan: _q3Answer,
                          bau: _q4Answer,
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
