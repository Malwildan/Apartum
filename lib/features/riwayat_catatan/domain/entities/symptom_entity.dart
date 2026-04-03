class SymptomEntity {
  final String id;
  final String date;
  final bool isBackdate;
  final List<BleedingEntity> bleedings;
  final PhysicalEntity physical;
  final List<String> moods;
  final AlertEntity? alert;
  final String createdAt;
  final String updatedAt;

  const SymptomEntity({
    required this.id,
    required this.date,
    required this.isBackdate,
    required this.bleedings,
    required this.physical,
    required this.moods,
    required this.alert,
    required this.createdAt,
    required this.updatedAt,
  });
}

class BleedingEntity {
  final String padUsage;
  final String clotSize;
  final String bloodColor;
  final String smell;

  const BleedingEntity({
    required this.padUsage,
    required this.clotSize,
    required this.bloodColor,
    required this.smell,
  });
}

class PhysicalEntity {
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

  const PhysicalEntity({
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

class AlertEntity {
  final String level;
  final int confidence;
  final List<AlertIssueEntity> issues;

  const AlertEntity({
    required this.level,
    required this.confidence,
    required this.issues,
  });
}

class AlertIssueEntity {
  final String code;
  final String disease;
  final String level;
  final String description;
  final List<String> symptoms;

  const AlertIssueEntity({
    required this.code,
    required this.disease,
    required this.level,
    required this.description,
    required this.symptoms,
  });
}
