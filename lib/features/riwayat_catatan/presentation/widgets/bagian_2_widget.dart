import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/riwayat_catatan_answer_data.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_checkbox_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_emoji_rating_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_radio_widget.dart';

class Bagian2Widget extends StatefulWidget {
  final VoidCallback onBack;
  final Function(Bagian2AnswerData) onNext;

  const Bagian2Widget({super.key, required this.onBack, required this.onNext});

  @override
  State<Bagian2Widget> createState() => _Bagian2WidgetState();
}

class _Bagian2WidgetState extends State<Bagian2Widget> {
  String? _suhuTubuh;
  int? _pusingLevel;
  int? _lemasLevel;
  int? _nyeriBetisLevel;
  int? _nyeriPerutLevel;

  List<String> _kondisiPerban = [];
  List<String> _masalahPayudara = [];
  List<String> _masalahBAK = [];
  List<String> _warnaUrine = [];
  List<String> _tubuhBengkak = [];
  List<String> _gejalaLain = [];

  @override
  Widget build(BuildContext context) {
    const subtitleNotMandatory =
        '*tidak wajib diisi, namun tetap disarankan untuk\nmengisi';
    const subtitleMultipleText =
        '*tidak wajib diisi, bisa pilih lebih dari satu';

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
                  'Bagian 2 – Kondisi Fisik',
                  style: AppTypography.h3.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4.h),
                Text(
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
                      value: 0.66,
                      backgroundColor: const Color(0xFFE5E5E5),
                      color: StaticColor.primaryPink,
                      minHeight: 6.h,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: Text(
                    'Langkah 2 dari 3',
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
                  title: 'Suhu tubuh saat ini',
                  subtitle: subtitleNotMandatory,
                  options: const ['≤36°C', '36,5°C', '37°C', '37,5°C', '≥38°C'],
                  selectedOption: _suhuTubuh,
                  onChanged: (value) => setState(() => _suhuTubuh = value),
                ),
                QuestionEmojiRatingWidget(
                  title: 'Pusing atau sakit kepala',
                  subtitle: subtitleNotMandatory,
                  selectedValue: _pusingLevel,
                  onChanged: (value) => setState(() => _pusingLevel = value),
                ),
                QuestionEmojiRatingWidget(
                  title: 'Lemas',
                  subtitle: subtitleNotMandatory,
                  selectedValue: _lemasLevel,
                  onChanged: (value) => setState(() => _lemasLevel = value),
                ),
                QuestionEmojiRatingWidget(
                  title: 'Nyeri betis',
                  subtitle: subtitleNotMandatory,
                  selectedValue: _nyeriBetisLevel,
                  onChanged: (value) => setState(() => _nyeriBetisLevel = value),
                ),
                QuestionEmojiRatingWidget(
                  title: 'Nyeri perut/luka jahitan',
                  subtitle: subtitleNotMandatory,
                  selectedValue: _nyeriPerutLevel,
                  onChanged: (value) => setState(() => _nyeriPerutLevel = value),
                ),
                QuestionCheckboxWidget(
                  title: 'Kondisi perban luka',
                  subtitle: subtitleMultipleText,
                  options: const [
                    'Tidak ada perban',
                    'Kering',
                    'Ada bercak darah',
                    'Basah',
                  ],
                  selectedOptions: _kondisiPerban,
                  onChanged: (value) => setState(() => _kondisiPerban = value),
                ),
                QuestionCheckboxWidget(
                  title: 'Masalah payudara',
                  subtitle: subtitleMultipleText,
                  options: const [
                    'Bengkak',
                    'Kemerahan',
                    'Nyeri pada puting',
                    'Nyeri pada payudara',
                  ],
                  selectedOptions: _masalahPayudara,
                  onChanged: (value) => setState(() => _masalahPayudara = value),
                ),
                QuestionCheckboxWidget(
                  title: 'Masalah Buang Air Kecil',
                  subtitle: subtitleMultipleText,
                  options: const [
                    'Tidak bisa BAK',
                    'Tidak bisa kontrol BAK',
                    'Ingin BAK terus menerus',
                    'Nyeri saat BAK',
                  ],
                  selectedOptions: _masalahBAK,
                  onChanged: (value) => setState(() => _masalahBAK = value),
                ),
                QuestionCheckboxWidget(
                  title: 'Warna urine',
                  subtitle: '*tidak wajib diisi',
                  options: const ['Urine berwarna kuning pekat/gelap'],
                  selectedOptions: _warnaUrine,
                  onChanged: (value) => setState(() => _warnaUrine = value),
                ),
                QuestionCheckboxWidget(
                  title: 'Pembengkakan pada tubuh',
                  subtitle: subtitleMultipleText,
                  options: const ['Pergelangan kaki', 'Tangan', 'Wajah'],
                  selectedOptions: _tubuhBengkak,
                  onChanged: (value) => setState(() => _tubuhBengkak = value),
                ),
                QuestionCheckboxWidget(
                  title: 'Gejala lainnya',
                  subtitle: subtitleMultipleText,
                  options: const [
                    'Kejang-kejang',
                    'Penglihatan kabur',
                    'Muntah',
                    'Nyeri ulu hati',
                    'Nyeri dada',
                    'Sesak napas',
                  ],
                  selectedOptions: _gejalaLain,
                  onChanged: (value) => setState(() => _gejalaLain = value),
                ),
              ],
            ),
          ),

          // Fixed Bottom Button
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                SizedBox(
                  width: 130.w,
                  height: 48.h,
                  child: OutlinedButton(
                    onPressed: widget.onBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: StaticColor.primaryPink,
                      side: const BorderSide(color: StaticColor.primaryPink),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back, size: 20.w),
                        SizedBox(width: 8.w),
                        Flexible(
                          child: AutoSizeText(
                            'Kembali',
                            style: AppTypography.b2.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            minFontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    label: 'Lanjutkan',
                    trailing: const Icon(Icons.arrow_forward),
                    onPressed: () => widget.onNext(Bagian2AnswerData(
                      suhuTubuh: _suhuTubuh,
                      pusingLevel: _pusingLevel,
                      lemasLevel: _lemasLevel,
                      nyeriBetisLevel: _nyeriBetisLevel,
                      nyeriPerutLevel: _nyeriPerutLevel,
                      kondisiPerban: _kondisiPerban,
                      masalahPayudara: _masalahPayudara,
                      masalahBAK: _masalahBAK,
                      warnaUrine: _warnaUrine,
                      tubuhBengkak: _tubuhBengkak,
                      gejalaLain: _gejalaLain,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
