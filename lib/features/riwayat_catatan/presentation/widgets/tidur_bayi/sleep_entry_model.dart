import 'package:flutter/material.dart';

enum EntryStatus { form, active, completed }

enum SleepFlowPhase { none, saving, success, error }

class SleepEntry {
  final String key;
  final String? sessionId;
  final bool isRemote;
  final TimeOfDay? start;
  final TimeOfDay? end;
  final EntryStatus status;

  const SleepEntry({
    required this.key,
    this.sessionId,
    this.isRemote = false,
    this.start,
    this.end,
    required this.status,
  });

  SleepEntry copyWith({
    String? sessionId,
    bool clearSessionId = false,
    bool? isRemote,
    TimeOfDay? start,
    bool clearStart = false,
    TimeOfDay? end,
    bool clearEnd = false,
    EntryStatus? status,
  }) => SleepEntry(
    key: key,
    sessionId: clearSessionId ? null : (sessionId ?? this.sessionId),
    isRemote: isRemote ?? this.isRemote,
    start: clearStart ? null : (start ?? this.start),
    end: clearEnd ? null : (end ?? this.end),
    status: status ?? this.status,
  );
}
