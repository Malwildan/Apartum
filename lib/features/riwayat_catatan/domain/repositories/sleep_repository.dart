import 'package:apartum/features/riwayat_catatan/domain/entities/sleep_daily_entity.dart';

abstract class SleepRepository {
  Future<SleepDailyEntity> getSleepDaily(String date);
  Future<void> addManualSleep(String start, String end);
  Future<void> startSleep();
  Future<void> endSleep();
}
