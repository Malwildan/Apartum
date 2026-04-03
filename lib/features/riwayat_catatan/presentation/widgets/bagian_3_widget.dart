import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/features/riwayat_catatan/presentation/riwayat_catatan_answer_data.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/question_chip_selection_widget.dart';
import 'package:flutter/material.dart';

class Bagian3Widget extends StatefulWidget {
  final VoidCallback onBack;
  final Function(Bagian3AnswerData) onSave;

  const Bagian3Widget({super.key, required this.onBack, required this.onSave});

  @override
  State<Bagian3Widget> createState() => _Bagian3WidgetState();
}

class _Bagian3WidgetState extends State<Bagian3Widget> {
  static const List<String> _positiveEmotionOptions = [
    '🙂 Bahagia',
    '😌 Tenang',
    '🙏 Bersyukur',
    '🔥 Bersemangat',
    '💪 Percaya diri',
    '🌤️ Optimis',
  ];

  static const List<String> _negativeEmotionOptions = [
    '😢 Sedih',
    '😟 Cemas',
    '😠 Mudah marah',
    '😵 Kewalahan',
    '😔 Kesepian',
    '💔 Putus asa',
  ];

  final List<String> _selectedPositiveEmotions = [];
  final List<String> _selectedNegativeEmotions = [];

  void _toggleEmotion(String emotion, List<String> selectedEmotions) {
    setState(() {
      if (selectedEmotions.contains(emotion)) {
        selectedEmotions.remove(emotion);
      } else {
        if (selectedEmotions.length < 3) {
          selectedEmotions.add(emotion);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Maksimal memilih 3 emosi.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

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
                  'Bagian 3 – Kondisi Emosi',
                  style: AppTypography.h3.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bagaimana perasaan Ibu hari ini?\n(Pilih maksimal 3 per kategori)',
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
                      value: 1.0,
                      backgroundColor: Color(0xFFE5E5E5),
                      color: StaticColor.primaryPink,
                      minHeight: 6,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Langkah 3 dari 3',
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
                QuestionChipSelectionWidget(
                  title: 'Emosi Positif',
                  options: _positiveEmotionOptions,
                  selectedOptions: _selectedPositiveEmotions,
                  onToggle: (emotion) =>
                      _toggleEmotion(emotion, _selectedPositiveEmotions),
                  backgroundColor: const Color(0xFFE8F6F3),
                  primaryColor: const Color(0xFF5AB6A5),
                ),
                QuestionChipSelectionWidget(
                  title: 'Emosi Negatif',
                  options: _negativeEmotionOptions,
                  selectedOptions: _selectedNegativeEmotions,
                  onToggle: (emotion) =>
                      _toggleEmotion(emotion, _selectedNegativeEmotions),
                  backgroundColor: const Color(0xFFFDEEEF),
                  primaryColor: const Color(0xFFF55A7B),
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
                    label: 'Simpan Pencatatan',
                    onPressed: () {
                      final selectedEmotions = [
                        ..._selectedPositiveEmotions,
                        ..._selectedNegativeEmotions,
                      ];

                      widget.onSave(
                        Bagian3AnswerData(
                          selectedEmotions: List.unmodifiable(selectedEmotions),
                        ),
                      );
                    },
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
