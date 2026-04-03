import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

import 'package:apartum/features/riwayat_catatan/domain/entities/sleep_daily_entity.dart';

enum SleepStatus { initial, loading, loaded, submitting, submitted, error }

@immutable
class SleepState extends Equatable {
  final SleepStatus status;
  final SleepDailyEntity? data;
  final String? errorMessage;

  const SleepState({
    this.status = SleepStatus.initial,
    this.data,
    this.errorMessage,
  });

  const SleepState.initial() : this();

  SleepState copyWith({
    SleepStatus? status,
    SleepDailyEntity? data,
    bool clearData = false,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return SleepState(
      status: status ?? this.status,
      data: clearData ? null : (data ?? this.data),
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
