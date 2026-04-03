import 'package:apartum/features/konseling/domain/entities/psychologist_entity.dart';

abstract class KonselingRepository {
  Future<List<PsychologistEntity>> getPsychologists();
  Future<PsychologistEntity> getPsychologistDetail(String id);
}
