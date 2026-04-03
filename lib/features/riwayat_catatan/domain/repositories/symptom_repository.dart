import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_entity.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_request_entity.dart';

abstract class SymptomRepository {
  Future<SymptomEntity> saveSymptom(SymptomRequestEntity request);
  Future<SymptomEntity> getSymptomDetail(String date);
  Future<List<SymptomEntity>> getSymptomHistory();
}

class SymptomNotFoundException implements Exception {
  final String message;

  const SymptomNotFoundException(this.message);

  @override
  String toString() => message;
}
