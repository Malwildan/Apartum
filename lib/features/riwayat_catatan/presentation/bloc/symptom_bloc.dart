import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:apartum/features/riwayat_catatan/domain/repositories/symptom_repository.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_event.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_state.dart';

class SymptomBloc extends Bloc<SymptomEvent, SymptomState> {
  final SymptomRepository _repository;

  SymptomBloc(this._repository) : super(SymptomState.initial()) {
    on<SelectDateEvent>(_onSelectDate, transformer: restartable());
    on<ChangeMonthEvent>(_onChangeMonth);
    on<FetchSymptomDetailEvent>(_onFetchSymptomDetail, transformer: restartable());
    on<SaveSymptomEvent>(_onSaveSymptom, transformer: restartable());
    on<ResetSymptomCacheEvent>(_onResetSymptomCache);

    if (!_isToday(state.selectedDate)) {
      add(FetchSymptomDetailEvent(_formatDate(state.selectedDate)));
    }
  }

  Future<void> _onSelectDate(
    SelectDateEvent event,
    Emitter<SymptomState> emit,
  ) async {
    final today = _dateOnly(DateTime.now());
    final selectedDate = _dateOnly(event.selectedDate);
    final focusedDay = _dateOnly(event.focusedDay).isAfter(today)
        ? today
        : _dateOnly(event.focusedDay);

    if (_isToday(selectedDate)) {
      final cachedTodayDetail = state.todaySymptomDetail;
      emit(
        state.copyWith(
          selectedDate: selectedDate,
          focusedDay: focusedDay,
          status:
              cachedTodayDetail != null ? SymptomStatus.loaded : SymptomStatus.initial,
          symptomDetail: cachedTodayDetail,
          clearSymptomDetail: cachedTodayDetail == null,
          clearErrorMessage: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        selectedDate: selectedDate,
        focusedDay: focusedDay,
        status: SymptomStatus.loading,
        clearErrorMessage: true,
      ),
    );

    await _fetchForCurrentDate(emit);
  }

  void _onChangeMonth(ChangeMonthEvent event, Emitter<SymptomState> emit) {
    final today = _dateOnly(DateTime.now());
    final rawFocused = _dateOnly(event.focusedDay);
    final newFocused = rawFocused.isAfter(today) ? today : rawFocused;
    if (newFocused.year == state.focusedDay.year &&
        newFocused.month == state.focusedDay.month &&
        newFocused.day == state.focusedDay.day) {
      return;
    }

    emit(state.copyWith(focusedDay: newFocused));
  }

  Future<void> _onFetchSymptomDetail(
    FetchSymptomDetailEvent event,
    Emitter<SymptomState> emit,
  ) async {
    if (_isToday(_parseDate(event.date))) {
      final cachedTodayDetail = state.todaySymptomDetail;
      if (cachedTodayDetail != null) {
        emit(
          state.copyWith(
            status: SymptomStatus.loaded,
            symptomDetail: cachedTodayDetail,
            clearErrorMessage: true,
          ),
        );
        return;
      }
      // No cache for today — fall through and fetch from API
    }

    emit(
      state.copyWith(
        status: SymptomStatus.loading,
        clearErrorMessage: true,
      ),
    );

    await _fetchByDate(event.date, emit);
  }

  Future<void> _onSaveSymptom(
    SaveSymptomEvent event,
    Emitter<SymptomState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SymptomStatus.saving,
        clearErrorMessage: true,
      ),
    );

    try {
      final saved = await _repository.saveSymptom(event.request);
      final isTodaySaved = _isToday(_parseDate(saved.date));
      emit(
        state.copyWith(
          status: SymptomStatus.saved,
          symptomDetail: saved,
          todaySymptomDetail: isTodaySaved ? saved : null,
          clearErrorMessage: true,
        ),
      );
      emit(
        state.copyWith(
          status: SymptomStatus.loaded,
          symptomDetail: saved,
          todaySymptomDetail: isTodaySaved ? saved : null,
          clearErrorMessage: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SymptomStatus.error,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  void _onResetSymptomCache(
    ResetSymptomCacheEvent event,
    Emitter<SymptomState> emit,
  ) {
    emit(
      state.copyWith(
        status: SymptomStatus.initial,
        clearSymptomDetail: true,
        clearTodaySymptomDetail: true,
        clearErrorMessage: true,
      ),
    );
  }

  Future<void> _fetchForCurrentDate(Emitter<SymptomState> emit) async {
    await _fetchByDate(_formatDate(state.selectedDate), emit);
  }

  Future<void> _fetchByDate(String date, Emitter<SymptomState> emit) async {
    try {
      final detail = await _repository.getSymptomDetail(date);
      final isTodayDetail = _isToday(_parseDate(date));
      emit(
        state.copyWith(
          status: SymptomStatus.loaded,
          symptomDetail: detail,
          todaySymptomDetail: isTodayDetail ? detail : null,
          clearErrorMessage: true,
        ),
      );
    } on SymptomNotFoundException {
      emit(
        state.copyWith(
          status: SymptomStatus.empty,
          clearSymptomDetail: true,
          clearErrorMessage: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SymptomStatus.error,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  DateTime _parseDate(String date) {
    final parts = date.split('-');
    if (parts.length != 3) {
      return DateTime.now();
    }

    return DateTime(
      int.tryParse(parts[0]) ?? 0,
      int.tryParse(parts[1]) ?? 1,
      int.tryParse(parts[2]) ?? 1,
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);
}
