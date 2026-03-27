import '../entities/day_sleep_entity.dart';

abstract class SleepRepository {
  List<DaySleepData> getWeeklySleep();
}
