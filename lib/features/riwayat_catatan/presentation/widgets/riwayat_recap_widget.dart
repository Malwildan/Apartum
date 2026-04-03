import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/riwayat_catatan_answer_data.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_checkbox_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_chip_selection_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_emoji_rating_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_radio_widget.dart';

class RiwayatRecapWidget extends StatelessWidget {
  final Bagian1AnswerData bagian1;
  final Bagian2AnswerData bagian2;
  final Bagian3AnswerData bagian3;
  final bool isEditable;
  final VoidCallback? onConfirm;
  final ValueChanged<Bagian1AnswerData>? onBagian1Changed;
  final ValueChanged<Bagian2AnswerData>? onBagian2Changed;
  final ValueChanged<Bagian3AnswerData>? onBagian3Changed;

  const RiwayatRecapWidget({
    super.key,
    required this.bagian1,
    required this.bagian2,
    required this.bagian3,
    this.isEditable = false,
    this.onConfirm,
    this.onBagian1Changed,
    this.onBagian2Changed,
    this.onBagian3Changed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _RecapSection(
          title: 'Bagian 1 – Pendarahan',
          pages: _bagian1Pages(),
        ),
        const SizedBox(height: 20),
        _RecapSection(
          title: 'Bagian 2 – Kondisi Fisik',
          pages: _bagian2Pages(),
        ),
        const SizedBox(height: 20),
        _RecapSection(
          title: 'Bagian 3 – Kondisi Emosi',
          pages: _bagian3Pages(),
        ),
        if (isEditable && onConfirm != null) ...[
          SizedBox(height: 12.h),
          AppButton(
            label: 'Konfirmasi Perubahan',
            onPressed: onConfirm,
          ),
        ],
        const SizedBox(height: 8),
      ],
    );
  }

  List<Widget> _bagian1Pages() => [
        QuestionRadioWidget(
          title: 'Berapa pembalut yang dipakai?',
          subtitle: '*wajib diisi, pilih salah satu',
          options: const [
            '1 pembalut / 24 jam',
            '1 pembalut / 6 jam',
            '1 pembalut / 2 jam',
            'Lebih cepat dari itu',
          ],
          selectedOption: bagian1.pembalut,
          onChanged: isEditable
              ? (value) => onBagian1Changed?.call(
                    bagian1.copyWith(pembalut: value),
                  )
              : (_) {},
        ),
        QuestionRadioWidget(
          title: 'Warna darah yang keluar',
          subtitle: '*wajib diisi, pilih salah satu',
          options: const ['Merah tua', 'Merah normal', 'Merah terang'],
          selectedOption: bagian1.warnaDarah,
          onChanged: isEditable
              ? (value) => onBagian1Changed?.call(
                    bagian1.copyWith(warnaDarah: value),
                  )
              : (_) {},
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
          selectedOption: bagian1.gumpalan,
          onChanged: isEditable
              ? (value) => onBagian1Changed?.call(
                    bagian1.copyWith(gumpalan: value),
                  )
              : (_) {},
        ),
        QuestionRadioWidget(
          title: 'Bau cairan dari jalan lahir',
          subtitle: '*wajib diisi, pilih salah satu',
          options: const [
            'Tidak berbau',
            'Berbau sedikit',
            'Berbau menyengat',
          ],
          selectedOption: bagian1.bau,
          onChanged: isEditable
              ? (value) => onBagian1Changed?.call(
                    bagian1.copyWith(bau: value),
                  )
              : (_) {},
        ),
      ];

  static const _subtitleNotMandatory =
      '*tidak wajib diisi, namun tetap disarankan untuk\nmengisi';
  static const _subtitleMultiple =
      '*tidak wajib diisi, bisa pilih lebih dari satu';

  List<Widget> _bagian2Pages() => [
        QuestionRadioWidget(
          title: 'Suhu tubuh saat ini',
          subtitle: _subtitleNotMandatory,
          options: const ['≤36°C', '36,5°C', '37°C', '37,5°C', '≥38°C'],
          selectedOption: bagian2.suhuTubuh,
          onChanged: isEditable
              ? (value) => onBagian2Changed?.call(
                    bagian2.copyWith(suhuTubuh: value),
                  )
              : (_) {},
        ),
        QuestionEmojiRatingWidget(
          title: 'Pusing atau sakit kepala',
          subtitle: _subtitleNotMandatory,
          selectedValue: bagian2.pusingLevel,
          onChanged: isEditable
              ? (value) => onBagian2Changed?.call(
                    bagian2.copyWith(pusingLevel: value),
                  )
              : (_) {},
        ),
        QuestionEmojiRatingWidget(
          title: 'Lemas',
          subtitle: _subtitleNotMandatory,
          selectedValue: bagian2.lemasLevel,
          onChanged: isEditable
              ? (value) => onBagian2Changed?.call(
                    bagian2.copyWith(lemasLevel: value),
                  )
              : (_) {},
        ),
        QuestionEmojiRatingWidget(
          title: 'Nyeri betis',
          subtitle: _subtitleNotMandatory,
          selectedValue: bagian2.nyeriBetisLevel,
          onChanged: isEditable
              ? (value) => onBagian2Changed?.call(
                    bagian2.copyWith(nyeriBetisLevel: value),
                  )
              : (_) {},
        ),
        QuestionEmojiRatingWidget(
          title: 'Nyeri perut/luka jahitan',
          subtitle: _subtitleNotMandatory,
          selectedValue: bagian2.nyeriPerutLevel,
          onChanged: isEditable
              ? (value) => onBagian2Changed?.call(
                    bagian2.copyWith(nyeriPerutLevel: value),
                  )
              : (_) {},
        ),
        QuestionCheckboxWidget(
          title: 'Kondisi perban luka',
          subtitle: _subtitleMultiple,
          options: const [
            'Tidak ada perban',
            'Kering',
            'Ada bercak darah',
            'Basah',
          ],
          selectedOptions: bagian2.kondisiPerban,
          onChanged: isEditable
              ? (value) => onBagian2Changed?.call(
                    bagian2.copyWith(kondisiPerban: value),
                  )
              : (_) {},
        ),
        QuestionCheckboxWidget(
          title: 'Masalah payudara',
          subtitle: _subtitleMultiple,
          options: const [
            'Bengkak',
            'Kemerahan',
            'Nyeri pada puting',
            'Nyeri pada payudara',
          ],
          selectedOptions: bagian2.masalahPayudara,
          onChanged: isEditable
              ? (value) => onBagian2Changed?.call(
                    bagian2.copyWith(masalahPayudara: value),
                  )
              : (_) {},
        ),
        QuestionCheckboxWidget(
          title: 'Masalah Buang Air Kecil',
          subtitle: _subtitleMultiple,
          options: const [
            'Tidak bisa BAK',
            'Tidak bisa kontrol BAK',
            'Ingin BAK terus menerus',
            'Nyeri saat BAK',
          ],
          selectedOptions: bagian2.masalahBAK,
          onChanged: isEditable
              ? (value) => onBagian2Changed?.call(
                    bagian2.copyWith(masalahBAK: value),
                  )
              : (_) {},
        ),
        QuestionCheckboxWidget(
          title: 'Warna urine',
          subtitle: '*tidak wajib diisi',
          options: const ['Urine berwarna kuning pekat/gelap'],
          selectedOptions: bagian2.warnaUrine,
          onChanged: isEditable
              ? (value) => onBagian2Changed?.call(
                    bagian2.copyWith(warnaUrine: value),
                  )
              : (_) {},
        ),
        QuestionCheckboxWidget(
          title: 'Pembengkakan pada tubuh',
          subtitle: _subtitleMultiple,
          options: const ['Pergelangan kaki', 'Tangan', 'Wajah'],
          selectedOptions: bagian2.tubuhBengkak,
          onChanged: isEditable
              ? (value) => onBagian2Changed?.call(
                    bagian2.copyWith(tubuhBengkak: value),
                  )
              : (_) {},
        ),
        QuestionCheckboxWidget(
          title: 'Gejala lainnya',
          subtitle: _subtitleMultiple,
          options: const [
            'Kejang-kejang',
            'Penglihatan kabur',
            'Muntah',
            'Nyeri ulu hati',
            'Nyeri dada',
            'Sesak napas',
          ],
          selectedOptions: bagian2.gejalaLain,
          onChanged: isEditable
              ? (value) => onBagian2Changed?.call(
                    bagian2.copyWith(gejalaLain: value),
                  )
              : (_) {},
        ),
      ];

  static const _positifOptions = [
    '🙂 Bahagia',
    '😌 Tenang',
    '🙏 Bersyukur',
    '🔥 Bersemangat',
    '💪 Percaya diri',
    '🌤️ Optimis',
  ];

  static const _negatifOptions = [
    '😢 Sedih',
    '😟 Cemas',
    '😠 Mudah marah',
    '😵 Kewalahan',
    '😔 Kesepian',
    '💔 Putus asa',
  ];

  List<Widget> _bagian3Pages() => [
        QuestionChipSelectionWidget(
          title: 'Emosi Positif',
          options: _positifOptions,
          selectedOptions: bagian3.selectedEmotions,
          onToggle: isEditable
              ? (value) => onBagian3Changed?.call(
                    bagian3.copyWith(
                      selectedEmotions: _toggleEmotion(
                        bagian3.selectedEmotions,
                        value,
                      ),
                    ),
                  )
              : (_) {},
          backgroundColor: const Color(0xFFE8F6F3),
          primaryColor: const Color(0xFF5AB6A5),
        ),
        QuestionChipSelectionWidget(
          title: 'Emosi Negatif',
          options: _negatifOptions,
          selectedOptions: bagian3.selectedEmotions,
          onToggle: isEditable
              ? (value) => onBagian3Changed?.call(
                    bagian3.copyWith(
                      selectedEmotions: _toggleEmotion(
                        bagian3.selectedEmotions,
                        value,
                      ),
                    ),
                  )
              : (_) {},
          backgroundColor: const Color(0xFFFDEEEF),
          primaryColor: const Color(0xFFF55A7B),
        ),
      ];

  List<String> _toggleEmotion(List<String> selectedEmotions, String value) {
    if (selectedEmotions.contains(value)) {
      return selectedEmotions.where((item) => item != value).toList();
    }

    return [...selectedEmotions, value];
  }
}

class _RecapSection extends StatefulWidget {
  final String title;
  final List<Widget> pages;

  const _RecapSection({required this.title, required this.pages});

  @override
  State<_RecapSection> createState() => _RecapSectionState();
}

class _RecapSectionState extends State<_RecapSection> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTypography.h3.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 2.h),
        Text(
          'Riwayat jawaban',
          style: AppTypography.b3.copyWith(color: StaticColor.textMuted),
        ),
        SizedBox(height: 12.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _NavArrow(
              icon: Icons.arrow_back_ios_rounded,
              enabled: _page > 0,
              onTap: () => setState(() => _page--),
            ),
            SizedBox(width: 8.w),
            Expanded(child: widget.pages[_page]),
            SizedBox(width: 8.w),
            _NavArrow(
              icon: Icons.arrow_forward_ios_rounded,
              enabled: _page < widget.pages.length - 1,
              onTap: () => setState(() => _page++),
            ),
          ],
        ),
      ],
    );
  }
}

class _NavArrow extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _NavArrow({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enabled
              ? StaticColor.primaryPink
              : StaticColor.primaryPink.withValues(alpha: 0.25),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 15.w,
          color: StaticColor.surface,
        ),
      ),
    );
  }
}
