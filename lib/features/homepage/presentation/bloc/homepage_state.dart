import 'package:apartum/features/riwayat_catatan/domain/entities/sleep_daily_entity.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_entity.dart';
import 'package:flutter/foundation.dart';

enum HomepageStatus { initial, loading, loaded, error }

@immutable
class HomepageState {
  final HomepageStatus status;
  final String? username;
  final SymptomEntity? todaySymptom;
  final List<SymptomEntity> symptomHistory;
  final SleepDailyEntity? todaySleep;
  final Map<String, SleepDailyEntity> weeklySleep;
  final String? errorMessage;

  const HomepageState({
    this.status = HomepageStatus.initial,
    this.username,
    this.todaySymptom,
    this.symptomHistory = const [],
    this.todaySleep,
    this.weeklySleep = const {},
    this.errorMessage,
  });

  HomepageState copyWith({
    HomepageStatus? status,
    String? username,
    SymptomEntity? todaySymptom,
    bool clearTodaySymptom = false,
    List<SymptomEntity>? symptomHistory,
    SleepDailyEntity? todaySleep,
    bool clearTodaySleep = false,
    Map<String, SleepDailyEntity>? weeklySleep,
    String? errorMessage,
  }) {
    return HomepageState(
      status: status ?? this.status,
      username: username ?? this.username,
      todaySymptom:
          clearTodaySymptom ? null : (todaySymptom ?? this.todaySymptom),
      symptomHistory: symptomHistory ?? this.symptomHistory,
      todaySleep: clearTodaySleep ? null : (todaySleep ?? this.todaySleep),
      weeklySleep: weeklySleep ?? this.weeklySleep,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
