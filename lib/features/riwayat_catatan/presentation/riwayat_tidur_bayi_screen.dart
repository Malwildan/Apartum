import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:apartum/features/riwayat_catatan/domain/entities/sleep_daily_entity.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/sleep_bloc.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/sleep_event.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/sleep_state.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/tidur_bayi/sleep_empty_state_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/tidur_bayi/sleep_entries_list_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/tidur_bayi/sleep_entry_model.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/tidur_bayi/sleep_flow_card_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/tidur_bayi/sleep_helpers.dart';

class RiwayatTidurBayiScreen extends StatefulWidget {
  final DateTime selectedDate;

  const RiwayatTidurBayiScreen({super.key, required this.selectedDate});

  @override
  State<RiwayatTidurBayiScreen> createState() =>
      _RiwayatTidurBayiScreenState();
}

class _RiwayatTidurBayiScreenState extends State<RiwayatTidurBayiScreen> {
  final List<SleepEntry> _entries = [];
  int _nextLocalEntryId = 0;
  String? _pendingSubmittedEntryKey;
  SleepFlowPhase _sleepFlowPhase = SleepFlowPhase.none;
  String? _sleepErrorMessage;

  static const int _maxEntries = 8;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<SleepBloc>().add(
        FetchSleepDailyEvent(SleepHelpers.formatDate(widget.selectedDate)),
      );
    });
  }

  @override
  void didUpdateWidget(RiwayatTidurBayiScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isSameDay(oldWidget.selectedDate, widget.selectedDate)) {
      setState(() {
        _entries.clear();
        _pendingSubmittedEntryKey = null;
      });
      context.read<SleepBloc>().add(
        FetchSleepDailyEvent(SleepHelpers.formatDate(widget.selectedDate)),
      );
    }
  }

  bool get _isToday => _isSameDay(widget.selectedDate, DateTime.now());

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Future<TimeOfDay?> _pickTime() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());

  void _addNewEntry() {
    if (_entries.length >= _maxEntries) return;
    setState(() {
      _entries.add(
        SleepEntry(
          key: 'local_${_nextLocalEntryId++}',
          status: EntryStatus.form,
        ),
      );
    });
  }

  void _updateEntryStart(int index, TimeOfDay time) {
    setState(() => _entries[index] = _entries[index].copyWith(start: time));
  }

  void _updateEntryEnd(int index, TimeOfDay time) {
    setState(() => _entries[index] = _entries[index].copyWith(end: time));
  }

  void _submitEntry(int index) {
    final entry = _entries[index];
    if (entry.start == null) return;

    setState(() {
      _entries[index] = entry.end != null
          ? entry.copyWith(status: EntryStatus.completed)
          : entry.copyWith(status: EntryStatus.active);
    });

    if (entry.end != null) {
      final payload = SleepHelpers.buildManualSleepPayload(
        entry.start!.hour,
        entry.start!.minute,
        entry.end!.hour,
        entry.end!.minute,
      );
      _pendingSubmittedEntryKey = entry.key;
      setState(() => _sleepFlowPhase = SleepFlowPhase.saving);
      context.read<SleepBloc>().add(
        AddManualSleepEvent(start: payload.$1, end: payload.$2),
      );
    }
  }

  void _markAwake(int index) async {
    final picked = await _pickTime();
    if (picked != null && mounted) {
      final entry = _entries[index];
      setState(() {
        _entries[index] = entry.copyWith(
          end: picked,
          status: EntryStatus.completed,
        );
        _sleepFlowPhase = SleepFlowPhase.saving;
      });

      if (entry.isRemote) {
        context.read<SleepBloc>().add(const EndSleepEvent());
        return;
      }

      if (entry.start == null) return;

      final payload = SleepHelpers.buildManualSleepPayload(
        entry.start!.hour,
        entry.start!.minute,
        picked.hour,
        picked.minute,
      );
      _pendingSubmittedEntryKey = entry.key;
      context
          .read<SleepBloc>()
          .add(AddManualSleepEvent(start: payload.$1, end: payload.$2));
    }
  }

  void _onSleepStateChanged(BuildContext context, SleepState state) {
    if (!mounted) return;

    if (state.status == SleepStatus.loaded) {
      if (_sleepFlowPhase == SleepFlowPhase.saving) {
        setState(() => _sleepFlowPhase = SleepFlowPhase.success);
      }
      _syncRemoteEntries(state.data);
      return;
    }

    if (state.status == SleepStatus.submitted) {
      if (_sleepFlowPhase == SleepFlowPhase.saving) {
        setState(() => _sleepFlowPhase = SleepFlowPhase.success);
      }
      return;
    }

    if (state.status == SleepStatus.error) {
      _pendingSubmittedEntryKey = null;
      if (_sleepFlowPhase == SleepFlowPhase.saving) {
        setState(() {
          _sleepFlowPhase = SleepFlowPhase.error;
          _sleepErrorMessage = state.errorMessage;
        });
      }
    }
  }

  void _syncRemoteEntries(SleepDailyEntity? daily) {
    final remoteEntries = (daily?.sessions ?? <SleepSessionEntity>[])
        .map(_mapSessionToEntry)
        .toList();

    setState(() {
      final localEntries = _entries
          .where((e) => !e.isRemote)
          .where((e) => e.key != _pendingSubmittedEntryKey)
          .toList();

      _entries
        ..clear()
        ..addAll(remoteEntries)
        ..addAll(localEntries);

      if (_entries.length > _maxEntries) {
        _entries.removeRange(_maxEntries, _entries.length);
      }

      _pendingSubmittedEntryKey = null;
    });
  }

  SleepEntry _mapSessionToEntry(SleepSessionEntity session) {
    final startParsed = SleepHelpers.parseTimeOfDay(session.start);
    final endParsed =
        session.end != null ? SleepHelpers.parseTimeOfDay(session.end!) : null;
    return SleepEntry(
      key: 'remote_${session.id}',
      sessionId: session.id,
      isRemote: true,
      start: TimeOfDay(hour: startParsed.hour, minute: startParsed.minute),
      end: endParsed != null
          ? TimeOfDay(hour: endParsed.hour, minute: endParsed.minute)
          : null,
      status: session.end == null ? EntryStatus.active : EntryStatus.completed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SleepBloc, SleepState>(
      listener: _onSleepStateChanged,
      child: _sleepFlowPhase != SleepFlowPhase.none
          ? SleepFlowCardWidget(
              phase: _sleepFlowPhase,
              errorMessage: _sleepErrorMessage,
              onDone: () => setState(() {
                _sleepFlowPhase = SleepFlowPhase.none;
                _sleepErrorMessage = null;
              }),
            )
          : _entries.isEmpty
              ? SleepEmptyStateWidget(
                  selectedDate: widget.selectedDate,
                  isToday: _isToday,
                  onAddNew: _addNewEntry,
                )
              : SleepEntriesListWidget(
                  entries: _entries,
                  isToday: _isToday,
                  maxEntries: _maxEntries,
                  onAddNew: _addNewEntry,
                  pickTime: _pickTime,
                  onStartChanged: _updateEntryStart,
                  onEndChanged: _updateEntryEnd,
                  onSubmit: _submitEntry,
                  onMarkAwake: _markAwake,
                ),
    );
  }
}
