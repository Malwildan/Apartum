import 'package:apartum/features/konseling/domain/entities/psychologist_entity.dart';
import 'package:apartum/features/konseling/data/models/schedule_model.dart';

class PsychologistModel extends PsychologistEntity {
  const PsychologistModel({
    required super.id,
    required super.name,
    required super.title,
    required super.job,
    required super.experienceYears,
    required super.priceIdr,
    required super.photoUrl,
    super.schedules,
  });

  factory PsychologistModel.fromJson(Map<String, dynamic> json) {
    return PsychologistModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? 'Nama Tidak Diketahui',
      title: json['title'] as String? ?? '-',
      job: json['job'] as String? ?? '-',
      experienceYears: json['experience_years'] as int? ?? 0,
      priceIdr: json['price_idr'] as num? ?? 0,
      photoUrl: json['photo_url'] as String? ?? '',
      schedules: json['schedules'] != null
          ? (json['schedules'] as List)
              .map((e) => ScheduleModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}
