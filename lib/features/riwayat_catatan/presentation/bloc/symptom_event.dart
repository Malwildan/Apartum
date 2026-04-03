import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_request_entity.dart';

@immutable
sealed class SymptomEvent extends Equatable {
  const SymptomEvent();

  @override
  List<Object?> get props => [];
}

class SelectDateEvent extends SymptomEvent {
  final DateTime selectedDate;
  final DateTime focusedDay;

  const SelectDateEvent({required this.selectedDate, required this.focusedDay});

  @override
  List<Object?> get props => [
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
        DateTime(focusedDay.year, focusedDay.month, focusedDay.day),
      ];
}

class ChangeMonthEvent extends SymptomEvent {
  final DateTime focusedDay;

  const ChangeMonthEvent(this.focusedDay);

  @override
  List<Object?> get props => [DateTime(focusedDay.year, focusedDay.month, focusedDay.day)];
}

class FetchSymptomDetailEvent extends SymptomEvent {
  final String date;

  const FetchSymptomDetailEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class SaveSymptomEvent extends SymptomEvent {
  final SymptomRequestEntity request;

  const SaveSymptomEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class ResetSymptomCacheEvent extends SymptomEvent {
  const ResetSymptomCacheEvent();
}
