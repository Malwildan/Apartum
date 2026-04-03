class SymptomRequestEntity {
  final String date;
  final List<BleedingRequestEntity> bleedings;
  final PhysicalRequestEntity physical;
  final List<String> moods;

  const SymptomRequestEntity({
    required this.date,
    required this.bleedings,
    required this.physical,
    required this.moods,
  });
}

class BleedingRequestEntity {
  final String padUsage;
  final String clotSize;
  final String bloodColor;
  final String smell;

  const BleedingRequestEntity({
    required this.padUsage,
    required this.clotSize,
    required this.bloodColor,
    required this.smell,
  });
}

class PhysicalRequestEntity {
  final String? temperature;
  final int? dizziness;
  final int? headache;
  final int? weakness;
  final int? calfPain;
  final int? abdominalPain;
  final List<String> wound;
  final List<String> urineProblems;
  final String? urineColor;
  final List<String> breastProblems;
  final List<String> swelling;
  final List<String> otherSymptoms;

  const PhysicalRequestEntity({
    this.temperature,
    this.dizziness,
    this.headache,
    this.weakness,
    this.calfPain,
    this.abdominalPain,
    this.wound = const [],
    this.urineProblems = const [],
    this.urineColor,
    this.breastProblems = const [],
    this.swelling = const [],
    this.otherSymptoms = const [],
  });
}
