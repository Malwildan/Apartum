import '../entities/day_sleep_entity.dart';
import '../repositories/sleep_repository.dart';

class GetWeeklySleep {
  final SleepRepository repository;

  GetWeeklySleep(this.repository);

  List<DaySleepData> call() => repository.getWeeklySleep();
}
