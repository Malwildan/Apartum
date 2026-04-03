import 'package:apartum/features/riwayat_catatan/domain/repositories/sleep_repository.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/sleep_event.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/sleep_state.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SleepBloc extends Bloc<SleepEvent, SleepState> {
  final SleepRepository _repository;
  String? _currentDate;

  SleepBloc(this._repository) : super(const SleepState.initial()) {
    on<FetchSleepDailyEvent>(_onFetchSleepDaily, transformer: restartable());
    on<AddManualSleepEvent>(_onAddManualSleep, transformer: restartable());
    on<StartSleepEvent>(_onStartSleep, transformer: restartable());
    on<EndSleepEvent>(_onEndSleep, transformer: restartable());
  }

  Future<void> _onFetchSleepDaily(
    FetchSleepDailyEvent event,
    Emitter<SleepState> emit,
  ) async {
    _currentDate = event.date;

    emit(state.copyWith(status: SleepStatus.loading, clearErrorMessage: true));

    await _fetchSleepDaily(event.date, emit);
  }

  Future<void> _onAddManualSleep(
    AddManualSleepEvent event,
    Emitter<SleepState> emit,
  ) async {
    await _performMutation(
      emit,
      () => _repository.addManualSleep(event.start, event.end),
    );
  }

  Future<void> _onStartSleep(
    StartSleepEvent event,
    Emitter<SleepState> emit,
  ) async {
    await _performMutation(emit, _repository.startSleep);
  }

  Future<void> _onEndSleep(
    EndSleepEvent event,
    Emitter<SleepState> emit,
  ) async {
    await _performMutation(emit, _repository.endSleep);
  }

  Future<void> _performMutation(
    Emitter<SleepState> emit,
    Future<void> Function() action,
  ) async {
    emit(
      state.copyWith(status: SleepStatus.submitting, clearErrorMessage: true),
    );

    try {
      await action();
      emit(
        state.copyWith(status: SleepStatus.submitted, clearErrorMessage: true),
      );
      await _fetchSleepDaily(_currentDate ?? _formatDate(DateTime.now()), emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: SleepStatus.error,
          errorMessage: _extractErrorMessage(e),
        ),
      );
    }
  }

  Future<void> _fetchSleepDaily(String date, Emitter<SleepState> emit) async {
    try {
      final daily = await _repository.getSleepDaily(date);
      _currentDate = date;
      emit(
        state.copyWith(
          status: SleepStatus.loaded,
          data: daily,
          clearErrorMessage: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SleepStatus.error,
          errorMessage: _extractErrorMessage(e),
        ),
      );
    }
  }

  String _extractErrorMessage(Object error) {
    return error.toString().replaceAll('Exception: ', '');
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
