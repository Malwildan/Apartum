import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/features/riwayat_catatan/presentation/riwayat_catatan_answer_data.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_checkbox_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_emoji_rating_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_radio_widget.dart';
import 'package:flutter/material.dart';

class Bagian2Widget extends StatefulWidget {
  final VoidCallback onBack;
  final Function(Bagian2AnswerData) onNext;

  const Bagian2Widget({super.key, required this.onBack, required this.onNext});

  @override
  State<Bagian2Widget> createState() => _Bagian2WidgetState();
}

class _Bagian2WidgetState extends State<Bagian2Widget> {

  String? suhuTubuh;
  int? pusingLevel;
  int? lemasLevel;
  int? nyeriBetisLevel;
  int? nyeriPerutLevel;

  List<String> kondisiPerban = [];
  List<String> masalahPayudara = [];
  List<String> masalahBAK = [];
  List<String> warnaUrine = [];
  List<String> tubuhBengkak = [];
  List<String> gejalaLain = [];

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
                  'Bagian 2 – Kondisi Fisik',
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
                      value: 0.66,
                      backgroundColor: Color(0xFFE5E5E5),
                      color: StaticColor.primaryPink,
                      minHeight: 6,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                QuestionRadioWidget(
                  title: 'Suhu tubuh saat ini',
                  subtitle: subtitleNotMandatory,
                  options: const ['≤36°C', '36,5°C', '37°C', '37,5°C', '≥38°C'],
                  selectedOption: suhuTubuh,
                  onChanged: (value) => setState(() => suhuTubuh = value),
                ),
                QuestionEmojiRatingWidget(
                  title: 'Pusing atau sakit kepala',
                  subtitle: subtitleNotMandatory,
                  selectedValue: pusingLevel,
                  onChanged: (value) => setState(() => pusingLevel = value),
                ),
                QuestionEmojiRatingWidget(
                  title: 'Lemas',
                  subtitle: subtitleNotMandatory,
                  selectedValue: lemasLevel,
                  onChanged: (value) => setState(() => lemasLevel = value),
                ),
                QuestionEmojiRatingWidget(
                  title: 'Nyeri betis',
                  subtitle: subtitleNotMandatory,
                  selectedValue: nyeriBetisLevel,
                  onChanged: (value) => setState(() => nyeriBetisLevel = value),
                ),
                QuestionEmojiRatingWidget(
                  title: 'Nyeri perut/luka jahitan',
                  subtitle: subtitleNotMandatory,
                  selectedValue: nyeriPerutLevel,
                  onChanged: (value) => setState(() => nyeriPerutLevel = value),
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
                  selectedOptions: kondisiPerban,
                  onChanged: (value) => setState(() => kondisiPerban = value),
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
                  selectedOptions: masalahPayudara,
                  onChanged: (value) => setState(() => masalahPayudara = value),
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
                  selectedOptions: masalahBAK,
                  onChanged: (value) => setState(() => masalahBAK = value),
                ),
                QuestionCheckboxWidget(
                  title: 'Warna urine',
                  subtitle: '*tidak wajib diisi',
                  options: const ['Urine berwarna kuning pekat/gelap'],
                  selectedOptions: warnaUrine,
                  onChanged: (value) => setState(() => warnaUrine = value),
                ),
                QuestionCheckboxWidget(
                  title: 'Pembengkakan pada tubuh',
                  subtitle: subtitleMultipleText,
                  options: const ['Pergelangan kaki', 'Tangan', 'Wajah'],
                  selectedOptions: tubuhBengkak,
                  onChanged: (value) => setState(() => tubuhBengkak = value),
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
                  selectedOptions: gejalaLain,
                  onChanged: (value) => setState(() => gejalaLain = value),
                ),
              ],
            ),
          ),

          // Fixed Bottom Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                SizedBox(
                  width: 130,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: widget.onBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: StaticColor.primaryPink,
                      side: const BorderSide(color: StaticColor.primaryPink),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_back, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Kembali',
                          style: AppTypography.b2.copyWith(
                            fontWeight: FontWeight.w600,
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
                      suhuTubuh: suhuTubuh,
                      pusingLevel: pusingLevel,
                      lemasLevel: lemasLevel,
                      nyeriBetisLevel: nyeriBetisLevel,
                      nyeriPerutLevel: nyeriPerutLevel,
                      kondisiPerban: kondisiPerban,
                      masalahPayudara: masalahPayudara,
                      masalahBAK: masalahBAK,
                      warnaUrine: warnaUrine,
                      tubuhBengkak: tubuhBengkak,
                      gejalaLain: gejalaLain,
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
