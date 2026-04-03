import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

@immutable
sealed class SleepEvent extends Equatable {
  const SleepEvent();

  @override
  List<Object?> get props => [];
}

class FetchSleepDailyEvent extends SleepEvent {
  final String date;

  const FetchSleepDailyEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class AddManualSleepEvent extends SleepEvent {
  final String start;
  final String end;

  const AddManualSleepEvent({required this.start, required this.end});

  @override
  List<Object?> get props => [start, end];
}

class StartSleepEvent extends SleepEvent {
  const StartSleepEvent();
}

class EndSleepEvent extends SleepEvent {
  const EndSleepEvent();
}
