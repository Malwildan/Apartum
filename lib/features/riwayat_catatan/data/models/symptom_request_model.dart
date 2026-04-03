import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_request_entity.dart';

class SymptomRequestModel extends SymptomRequestEntity {
  const SymptomRequestModel({
    required super.date,
    required super.bleedings,
    required super.physical,
    required super.moods,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'bleedings': bleedings
          .map(
            (item) => BleedingRequestModel(
              padUsage: item.padUsage,
              clotSize: item.clotSize,
              bloodColor: item.bloodColor,
              smell: item.smell,
            ).toJson(),
          )
          .toList(),
      'physical': PhysicalRequestModel(
        temperature: physical.temperature,
        dizziness: physical.dizziness,
        headache: physical.headache,
        weakness: physical.weakness,
        calfPain: physical.calfPain,
        abdominalPain: physical.abdominalPain,
        wound: physical.wound,
        urineProblems: physical.urineProblems,
        urineColor: physical.urineColor,
        breastProblems: physical.breastProblems,
        swelling: physical.swelling,
        otherSymptoms: physical.otherSymptoms,
      ).toJson(),
      'moods': moods,
    };
  }
}

class BleedingRequestModel extends BleedingRequestEntity {
  const BleedingRequestModel({
    required super.padUsage,
    required super.clotSize,
    required super.bloodColor,
    required super.smell,
  });

  Map<String, dynamic> toJson() {
    return {
      'pad_usage': padUsage,
      'clot_size': clotSize,
      'blood_color': bloodColor,
      'smell': smell,
    };
  }
}

class PhysicalRequestModel extends PhysicalRequestEntity {
  const PhysicalRequestModel({
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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (temperature != null) data['temperature'] = temperature;
    if (dizziness != null) data['dizziness'] = dizziness;
    if (headache != null) data['headache'] = headache;
    if (weakness != null) data['weakness'] = weakness;
    if (calfPain != null) data['calf_pain'] = calfPain;
    if (abdominalPain != null) data['abdominal_pain'] = abdominalPain;
    if (wound.isNotEmpty) data['wound'] = wound;
    if (urineProblems.isNotEmpty) data['urine_problems'] = urineProblems;
    if (urineColor != null && urineColor!.isNotEmpty) data['urine_color'] = urineColor;
    if (breastProblems.isNotEmpty) data['breast_problems'] = breastProblems;
    if (swelling.isNotEmpty) data['swelling'] = swelling;
    if (otherSymptoms.isNotEmpty) data['other_symptoms'] = otherSymptoms;

    return data;
  }
}
