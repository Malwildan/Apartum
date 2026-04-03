import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_entity.dart';

class SymptomModel extends SymptomEntity {
  const SymptomModel({
    required super.id,
    required super.date,
    required super.isBackdate,
    required super.bleedings,
    required super.physical,
    required super.moods,
    required super.alert,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SymptomModel.fromJson(Map<String, dynamic> json) {
    return SymptomModel(
      id: json['id']?.toString() ?? '',
      date: json['date'] as String? ?? '',
      isBackdate: json['is_backdate'] as bool? ?? false,
      bleedings: (json['bleedings'] as List<dynamic>? ?? [])
          .map((item) => BleedingModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      physical: PhysicalModel.fromJson(json['physical'] as Map<String, dynamic>? ?? {}),
      moods: (json['moods'] as List<dynamic>? ?? [])
          .map((item) => item.toString())
          .toList(),
      alert: json['alert'] is Map<String, dynamic>
          ? AlertModel.fromJson(json['alert'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }
}

class BleedingModel extends BleedingEntity {
  const BleedingModel({
    required super.padUsage,
    required super.clotSize,
    required super.bloodColor,
    required super.smell,
  });

  factory BleedingModel.fromJson(Map<String, dynamic> json) {
    return BleedingModel(
      padUsage: json['pad_usage'] as String? ?? '',
      clotSize: json['clot_size'] as String? ?? '',
      bloodColor: json['blood_color'] as String? ?? '',
      smell: json['smell'] as String? ?? '',
    );
  }
}

class PhysicalModel extends PhysicalEntity {
  const PhysicalModel({
    super.temperature,
    super.dizziness,
    super.headache,
    super.weakness,
    super.calfPain,
    super.abdominalPain,
    super.wound,
    super.urineProblems,
    super.urineColor,
    super.breastProblems,
    super.swelling,
    super.otherSymptoms,
  });

  factory PhysicalModel.fromJson(Map<String, dynamic> json) {
    return PhysicalModel(
      temperature: json['temperature'] as String?,
      dizziness: json['dizziness'] as int?,
      headache: json['headache'] as int?,
      weakness: json['weakness'] as int?,
      calfPain: json['calf_pain'] as int?,
      abdominalPain: json['abdominal_pain'] as int?,
      wound: (json['wound'] as List<dynamic>? ?? [])
          .map((item) => item.toString())
          .toList(),
      urineProblems: (json['urine_problems'] as List<dynamic>? ?? [])
          .map((item) => item.toString())
          .toList(),
      urineColor: json['urine_color'] as String?,
      breastProblems: (json['breast_problems'] as List<dynamic>? ?? [])
          .map((item) => item.toString())
          .toList(),
      swelling: (json['swelling'] as List<dynamic>? ?? [])
          .map((item) => item.toString())
          .toList(),
      otherSymptoms: (json['other_symptoms'] as List<dynamic>? ?? [])
          .map((item) => item.toString())
          .toList(),
    );
  }
}

class AlertModel extends AlertEntity {
  const AlertModel({
    required super.level,
    required super.confidence,
    required super.issues,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      level: json['level'] as String? ?? '',
      confidence: json['confidence'] as int? ?? 0,
      issues: (json['issues'] as List<dynamic>? ?? [])
          .map((item) => AlertIssueModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AlertIssueModel extends AlertIssueEntity {
  const AlertIssueModel({
    required super.code,
    required super.disease,
    required super.level,
    required super.description,
    required super.symptoms,
  });

  factory AlertIssueModel.fromJson(Map<String, dynamic> json) {
    return AlertIssueModel(
      code: json['code'] as String? ?? '',
      disease: json['disease'] as String? ?? '',
      level: json['level'] as String? ?? '',
      description: json['description'] as String? ?? '',
      symptoms: (json['symptoms'] as List<dynamic>? ?? [])
          .map((item) => item.toString())
          .toList(),
    );
  }
}
