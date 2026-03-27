import '../../domain/entities/day_sleep_entity.dart';
import '../../domain/repositories/sleep_repository.dart';
import '../models/day_sleep_data_model.dart';

class SleepRepositoryImpl implements SleepRepository {
  @override
  List<DaySleepData> getWeeklySleep() => weekDataSample;
}
