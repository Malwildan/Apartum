import 'package:apartum/core/network/token_storage.dart';
import 'package:apartum/features/homepage/presentation/bloc/homepage_event.dart';
import 'package:apartum/features/homepage/presentation/bloc/homepage_state.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/sleep_daily_entity.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_entity.dart';
import 'package:apartum/features/riwayat_catatan/domain/repositories/sleep_repository.dart';
import 'package:apartum/features/riwayat_catatan/domain/repositories/symptom_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final SymptomRepository _symptomRepository;
  final SleepRepository _sleepRepository;
  final TokenStorage _tokenStorage;

  HomepageBloc({
    required SymptomRepository symptomRepository,
    required SleepRepository sleepRepository,
    required TokenStorage tokenStorage,
  })  : _symptomRepository = symptomRepository,
        _sleepRepository = sleepRepository,
        _tokenStorage = tokenStorage,
        super(const HomepageState()) {
    on<LoadHomepageEvent>(_onLoadHomepage);
  }

  Future<void> _onLoadHomepage(
    LoadHomepageEvent event,
    Emitter<HomepageState> emit,
  ) async {
    emit(state.copyWith(status: HomepageStatus.loading));

    try {
      final now = DateTime.now();
      final todayStr = _formatDate(now);

      final username = await _tokenStorage.getUserName();

      SymptomEntity? todaySymptom;
      try {
        todaySymptom = await _symptomRepository.getSymptomDetail(todayStr);
      } on SymptomNotFoundException {
        todaySymptom = null;
      } catch (_) {
        todaySymptom = null;
      }

      List<SymptomEntity> symptomHistory;
      try {
        symptomHistory = await _symptomRepository.getSymptomHistory();
      } catch (_) {
        symptomHistory = [];
      }

      SleepDailyEntity? todaySleep;
      try {
        todaySleep = await _sleepRepository.getSleepDaily(todayStr);
      } catch (_) {
        todaySleep = null;
      }

      final monday = now.subtract(Duration(days: now.weekday - 1));
      final weekDates =
          List.generate(7, (i) => monday.add(Duration(days: i)));

      final sleepResults = await Future.wait(
        weekDates.map((d) async {
          final dateStr = _formatDate(d);
          try {
            final entity = await _sleepRepository.getSleepDaily(dateStr);
            return MapEntry(dateStr, entity);
          } catch (_) {
            return null;
          }
        }),
      );

      final weeklySleep = <String, SleepDailyEntity>{};
      for (final entry in sleepResults) {
        if (entry != null) {
          weeklySleep[entry.key] = entry.value;
        }
      }

      emit(state.copyWith(
        status: HomepageStatus.loaded,
        username: username,
        todaySymptom: todaySymptom,
        clearTodaySymptom: todaySymptom == null,
        symptomHistory: symptomHistory,
        todaySleep: todaySleep,
        clearTodaySleep: todaySleep == null,
        weeklySleep: weeklySleep,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomepageStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
