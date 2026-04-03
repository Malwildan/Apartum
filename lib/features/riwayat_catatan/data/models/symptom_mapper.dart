import 'package:apartum/features/riwayat_catatan/data/models/symptom_request_model.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_entity.dart';
import 'package:apartum/features/riwayat_catatan/presentation/riwayat_catatan_answer_data.dart';

class SymptomAnswerBundle {
  final Bagian1AnswerData bagian1;
  final Bagian2AnswerData bagian2;
  final Bagian3AnswerData bagian3;

  const SymptomAnswerBundle({
    required this.bagian1,
    required this.bagian2,
    required this.bagian3,
  });
}

class SymptomMapper {
  static const Map<String, String> _padUsageToApi = {
    '1 pembalut / 24 jam': '24h',
    '1 pembalut / 6 jam': '6h',
    '1 pembalut / 2 jam': '2h',
    'Lebih cepat dari itu': '<2h',
  };

  static const Map<String, String> _bloodColorToApi = {
    'Merah tua': 'dark_red',
    'Merah normal': 'normal_red',
    'Merah terang': 'bright_red',
  };

  static const Map<String, String> _clotSizeToApi = {
    'Tidak ada': 'none',
    'Koin kecil': 'small_coin',
    'Koin besar': 'large_coin',
    'Bola pingpong': 'pingpong',
  };

  static const Map<String, String> _smellToApi = {
    'Tidak berbau': 'none',
    'Berbau sedikit': 'mild',
    'Berbau menyengat': 'strong',
  };

  static const Map<String, String> _temperatureToApi = {
    '≤36°C': '<=36',
    '36,5°C': '36.5',
    '37°C': '37',
    '37,5°C': '37.5',
    '≥38°C': '>=38',
  };

  static const Map<String, String> _woundToApi = {
    'Tidak ada perban': 'tidak_ada_perban',
    'Kering': 'kering',
    'Ada bercak darah': 'bercak_darah',
    'Basah': 'basah',
  };

  static const Map<String, String> _urineProblemsToApi = {
    'Tidak bisa BAK': 'tidak_bisa_bak',
    'Tidak bisa kontrol BAK': 'tidak_kontrol',
    'Ingin BAK terus menerus': 'sering_bak',
    'Nyeri saat BAK': 'nyeri_bak',
  };

  static const Map<String, String> _breastProblemsToApi = {
    'Bengkak': 'bengkak',
    'Kemerahan': 'kemerahan',
    'Nyeri pada puting': 'nyeri_puting',
    'Nyeri pada payudara': 'nyeri_payudara',
  };

  static const Map<String, String> _swellingToApi = {
    'Pergelangan kaki': 'kaki',
    'Tangan': 'tangan',
    'Wajah': 'wajah',
  };

  static const Map<String, String> _otherSymptomsToApi = {
    'Kejang-kejang': 'kejang',
    'Penglihatan kabur': 'penglihatan_kabur',
    'Muntah': 'muntah',
    'Nyeri ulu hati': 'nyeri_ulu_hati',
    'Nyeri dada': 'nyeri_dada',
    'Sesak napas': 'sesak_napas',
  };

  static const Map<String, String> _moodToApi = {
    '🙂 Bahagia': 'bahagia',
    '😌 Tenang': 'tenang',
    '🙏 Bersyukur': 'bersyukur',
    '🔥 Bersemangat': 'bersemangat',
    '💪 Percaya diri': 'percaya_diri',
    '🌤️ Optimis': 'optimis',
    '😢 Sedih': 'sedih',
    '😟 Cemas': 'cemas',
    '😠 Mudah marah': 'mudah_marah',
    '😵 Kewalahan': 'kewalahan',
    '😔 Kesepian': 'kesepian',
    '💔 Putus asa': 'putus_asa',
  };

  static Map<String, String> get _padUsageFromApi => _reverseMap(_padUsageToApi);
  static Map<String, String> get _bloodColorFromApi => _reverseMap(_bloodColorToApi);
  static Map<String, String> get _clotSizeFromApi => _reverseMap(_clotSizeToApi);
  static Map<String, String> get _smellFromApi => _reverseMap(_smellToApi);
  static Map<String, String> get _temperatureFromApi => _reverseMap(_temperatureToApi);
  static Map<String, String> get _woundFromApi => _reverseMap(_woundToApi);
  static Map<String, String> get _urineProblemsFromApi => _reverseMap(_urineProblemsToApi);
  static Map<String, String> get _breastProblemsFromApi => _reverseMap(_breastProblemsToApi);
  static Map<String, String> get _swellingFromApi => _reverseMap(_swellingToApi);
  static Map<String, String> get _otherSymptomsFromApi => _reverseMap(_otherSymptomsToApi);
  static Map<String, String> get _moodFromApi => _reverseMap(_moodToApi);

  static SymptomRequestModel fromAnswerData({
    required DateTime selectedDate,
    required Bagian1AnswerData bagian1,
    required Bagian2AnswerData bagian2,
    required Bagian3AnswerData bagian3,
  }) {
    return SymptomRequestModel(
      date: _formatDate(selectedDate),
      bleedings: [
        BleedingRequestModel(
          padUsage: _padUsageToApi[bagian1.pembalut] ?? '24h',
          clotSize: _clotSizeToApi[bagian1.gumpalan] ?? 'none',
          bloodColor: _bloodColorToApi[bagian1.warnaDarah] ?? 'normal_red',
          smell: _smellToApi[bagian1.bau] ?? 'mild',
        ),
      ],
      physical: PhysicalRequestModel(
        temperature: bagian2.suhuTubuh == null
            ? null
            : _temperatureToApi[bagian2.suhuTubuh!],
        dizziness: bagian2.pusingLevel,
        headache: bagian2.pusingLevel,
        weakness: bagian2.lemasLevel,
        calfPain: bagian2.nyeriBetisLevel,
        abdominalPain: bagian2.nyeriPerutLevel,
        wound: bagian2.kondisiPerban
            .map((item) => _woundToApi[item])
            .whereType<String>()
            .toList(),
        urineProblems: bagian2.masalahBAK
            .map((item) => _urineProblemsToApi[item])
            .whereType<String>()
            .toList(),
        urineColor: bagian2.warnaUrine.isNotEmpty ? 'dark' : null,
        breastProblems: bagian2.masalahPayudara
            .map((item) => _breastProblemsToApi[item])
            .whereType<String>()
            .toList(),
        swelling: bagian2.tubuhBengkak
            .map((item) => _swellingToApi[item])
            .whereType<String>()
            .toList(),
        otherSymptoms: bagian2.gejalaLain
            .map((item) => _otherSymptomsToApi[item])
            .whereType<String>()
            .toList(),
      ),
      moods: bagian3.selectedEmotions
          .map((item) => _moodToApi[item])
          .whereType<String>()
          .toList(),
    );
  }

  static SymptomAnswerBundle toAnswerData(SymptomEntity symptom) {
    final firstBleeding = symptom.bleedings.isNotEmpty
        ? symptom.bleedings.first
        : const BleedingEntity(
            padUsage: '24h',
            clotSize: 'none',
            bloodColor: 'normal_red',
            smell: 'mild',
          );

    return SymptomAnswerBundle(
      bagian1: Bagian1AnswerData(
        pembalut: _padUsageFromApi[firstBleeding.padUsage],
        warnaDarah: _bloodColorFromApi[firstBleeding.bloodColor],
        gumpalan: _clotSizeFromApi[firstBleeding.clotSize],
        bau: _smellFromApi[firstBleeding.smell],
      ),
      bagian2: Bagian2AnswerData(
        suhuTubuh: symptom.physical.temperature == null
            ? null
            : _temperatureFromApi[symptom.physical.temperature!],
        pusingLevel: symptom.physical.dizziness,
        lemasLevel: symptom.physical.weakness,
        nyeriBetisLevel: symptom.physical.calfPain,
        nyeriPerutLevel: symptom.physical.abdominalPain,
        kondisiPerban: symptom.physical.wound
            .map((item) => _woundFromApi[item])
            .whereType<String>()
            .toList(),
        masalahPayudara: symptom.physical.breastProblems
            .map((item) => _breastProblemsFromApi[item])
            .whereType<String>()
            .toList(),
        masalahBAK: symptom.physical.urineProblems
            .map((item) => _urineProblemsFromApi[item])
            .whereType<String>()
            .toList(),
        warnaUrine:
            symptom.physical.urineColor == 'dark' ? ['Urine berwarna kuning pekat/gelap'] : [],
        tubuhBengkak: symptom.physical.swelling
            .map((item) => _swellingFromApi[item])
            .whereType<String>()
            .toList(),
        gejalaLain: symptom.physical.otherSymptoms
            .map((item) => _otherSymptomsFromApi[item])
            .whereType<String>()
            .toList(),
      ),
      bagian3: Bagian3AnswerData(
        selectedEmotions: symptom.moods
            .map((item) => _moodFromApi[item])
            .whereType<String>()
            .toList(),
      ),
    );
  }

  static String formatDateForApi(DateTime date) => _formatDate(date);

  static String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static Map<String, String> _reverseMap(Map<String, String> source) {
    return source.map((key, value) => MapEntry(value, key));
  }
}
