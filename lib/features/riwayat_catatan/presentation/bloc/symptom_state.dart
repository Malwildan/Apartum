import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_entity.dart';

enum SymptomStatus { initial, loading, loaded, empty, saving, saved, error }

@immutable
class SymptomState extends Equatable {
  final DateTime selectedDate;
  final DateTime focusedDay;
  final SymptomStatus status;
  final SymptomEntity? symptomDetail;
  final SymptomEntity? todaySymptomDetail;
  final String? errorMessage;

  const SymptomState({
    required this.selectedDate,
    required this.focusedDay,
    this.status = SymptomStatus.initial,
    this.symptomDetail,
    this.todaySymptomDetail,
    this.errorMessage,
  });

  factory SymptomState.initial() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return SymptomState(selectedDate: today, focusedDay: today);
  }

  SymptomState copyWith({
    DateTime? selectedDate,
    DateTime? focusedDay,
    SymptomStatus? status,
    SymptomEntity? symptomDetail,
    bool clearSymptomDetail = false,
    SymptomEntity? todaySymptomDetail,
    bool clearTodaySymptomDetail = false,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return SymptomState(
      selectedDate: selectedDate ?? this.selectedDate,
      focusedDay: focusedDay ?? this.focusedDay,
      status: status ?? this.status,
      symptomDetail:
          clearSymptomDetail ? null : (symptomDetail ?? this.symptomDetail),
      todaySymptomDetail: clearTodaySymptomDetail
          ? null
          : (todaySymptomDetail ?? this.todaySymptomDetail),
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
        DateTime(focusedDay.year, focusedDay.month, focusedDay.day),
        status,
        symptomDetail,
        todaySymptomDetail,
        errorMessage,
      ];
}
