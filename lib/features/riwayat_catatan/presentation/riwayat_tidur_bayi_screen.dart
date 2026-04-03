import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/global_widget/status_card_widget.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/sleep_daily_entity.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/sleep_bloc.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/sleep_event.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/sleep_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum _EntryStatus { form, active, completed }

enum _SleepFlowPhase { none, saving, success, error }

class _SleepEntry {
  final String key;
  final String? sessionId;
  final bool isRemote;
  final TimeOfDay? start;
  final TimeOfDay? end;
  final _EntryStatus status;

  const _SleepEntry({
    required this.key,
    this.sessionId,
    this.isRemote = false,
    this.start,
    this.end,
    required this.status,
  });

  _SleepEntry copyWith({
    String? sessionId,
    bool clearSessionId = false,
    bool? isRemote,
    TimeOfDay? start,
    bool clearStart = false,
    TimeOfDay? end,
    bool clearEnd = false,
    _EntryStatus? status,
  }) => _SleepEntry(
    key: key,
    sessionId: clearSessionId ? null : (sessionId ?? this.sessionId),
    isRemote: isRemote ?? this.isRemote,
    start: clearStart ? null : (start ?? this.start),
    end: clearEnd ? null : (end ?? this.end),
    status: status ?? this.status,
  );
}

class RiwayatTidurBayiScreen extends StatefulWidget {
  final DateTime selectedDate;

  const RiwayatTidurBayiScreen({super.key, required this.selectedDate});

  @override
  State<RiwayatTidurBayiScreen> createState() => _RiwayatTidurBayiScreenState();
}

class _RiwayatTidurBayiScreenState extends State<RiwayatTidurBayiScreen> {
  final List<_SleepEntry> _entries = [];
  int _nextLocalEntryId = 0;
  String? _pendingSubmittedEntryKey;
  _SleepFlowPhase _sleepFlowPhase = _SleepFlowPhase.none;
  String? _sleepErrorMessage;

  static const int _maxEntries = 8;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<SleepBloc>().add(FetchSleepDailyEvent(_formatDate(widget.selectedDate)));
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
      context.read<SleepBloc>().add(FetchSleepDailyEvent(_formatDate(widget.selectedDate)));
    }
  }

  bool get _isToday => _isSameDay(widget.selectedDate, DateTime.now());

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _formatTime(TimeOfDay time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

  String _formatDuration(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    var endMinutes = end.hour * 60 + end.minute;
    if (endMinutes < startMinutes) endMinutes += 24 * 60;
    final total = endMinutes - startMinutes;
    if (total <= 0) return '0 menit';
    final h = total ~/ 60;
    final m = total % 60;
    if (h == 0) return '$m menit';
    if (m == 0) return '$h jam';
    return '$h jam $m menit';
  }

  Future<TimeOfDay?> _pickTime() async {
    return showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  void _addNewEntry() {
    if (_entries.length >= _maxEntries) return;
    setState(() {
      _entries.add(
        _SleepEntry(
          key: 'local_${_nextLocalEntryId++}',
          status: _EntryStatus.form,
        ),
      );
    });
  }

  void _updateEntryStart(int index, TimeOfDay time) {
    setState(() {
      _entries[index] = _entries[index].copyWith(start: time);
    });
  }

  void _updateEntryEnd(int index, TimeOfDay time) {
    setState(() {
      _entries[index] = _entries[index].copyWith(end: time);
    });
  }

  void _submitEntry(int index) {
    final entry = _entries[index];
    if (entry.start == null) return;

    setState(() {
      if (entry.end != null) {
        _entries[index] = entry.copyWith(status: _EntryStatus.completed);
      } else {
        _entries[index] = entry.copyWith(status: _EntryStatus.active);
      }
    });

    if (entry.end != null) {
      final payload = _buildManualSleepPayload(entry.start!, entry.end!);
      _pendingSubmittedEntryKey = entry.key;
      setState(() => _sleepFlowPhase = _SleepFlowPhase.saving);
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
          status: _EntryStatus.completed,
        );
        _sleepFlowPhase = _SleepFlowPhase.saving;
      });

      if (entry.isRemote) {
        context.read<SleepBloc>().add(const EndSleepEvent());
        return;
      }

      if (entry.start == null) return;

      final payload = _buildManualSleepPayload(entry.start!, picked);
      _pendingSubmittedEntryKey = entry.key;
      context.read<SleepBloc>().add(
        AddManualSleepEvent(start: payload.$1, end: payload.$2),
      );
    }
  }

  void _onSleepStateChanged(BuildContext context, SleepState state) {
    if (!mounted) return;

    if (state.status == SleepStatus.loaded) {
      if (_sleepFlowPhase == _SleepFlowPhase.saving) {
        setState(() => _sleepFlowPhase = _SleepFlowPhase.success);
      }
      _syncRemoteEntries(state.data);
      return;
    }

    if (state.status == SleepStatus.submitted) {
      if (_sleepFlowPhase == _SleepFlowPhase.saving) {
        setState(() => _sleepFlowPhase = _SleepFlowPhase.success);
      }
      return;
    }

    if (state.status == SleepStatus.error) {
      _pendingSubmittedEntryKey = null;
      if (_sleepFlowPhase == _SleepFlowPhase.saving) {
        setState(() {
          _sleepFlowPhase = _SleepFlowPhase.error;
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
          .where((entry) => !entry.isRemote)
          .where((entry) => entry.key != _pendingSubmittedEntryKey)
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

  _SleepEntry _mapSessionToEntry(SleepSessionEntity session) {
    return _SleepEntry(
      key: 'remote_${session.id}',
      sessionId: session.id,
      isRemote: true,
      start: _parseTimeOfDay(session.start),
      end: session.end != null ? _parseTimeOfDay(session.end!) : null,
      status: session.end == null
          ? _EntryStatus.active
          : _EntryStatus.completed,
    );
  }

  TimeOfDay _parseTimeOfDay(String value) {
    try {
      if (value.isEmpty) return const TimeOfDay(hour: 0, minute: 0);
      // Handle simple HH:mm format returned by the API.
      final colonParts = value.split(':');
      if (colonParts.length == 2) {
        final hour = int.tryParse(colonParts[0]);
        final minute = int.tryParse(colonParts[1]);
        if (hour != null && minute != null) {
          return TimeOfDay(hour: hour, minute: minute);
        }
      }
      // Fall back to ISO8601/RFC3339 for full datetime strings.
      // Dart's DateTime.parse supports up to 6 fractional-second digits;
      // truncate extra digits if the backend returns nanosecond precision.
      final normalized = value.replaceFirstMapped(
        RegExp(r'(\.\d{6})\d+'),
        (m) => m.group(1)!,
      );
      final dateTime = DateTime.parse(normalized).toLocal();
      return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    } catch (_) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
  }

  (String, String) _buildManualSleepPayload(TimeOfDay start, TimeOfDay end) {
    final startDateTime = _dateTimeForToday(start);
    var endDateTime = _dateTimeForToday(end);

    if (endDateTime.isBefore(startDateTime)) {
      endDateTime = endDateTime.add(const Duration(days: 1));
    }

    return (_toRfc3339(startDateTime), _toRfc3339(endDateTime));
  }

  DateTime _dateTimeForToday(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  String _toRfc3339(DateTime dateTime) {
    final year = dateTime.year.toString().padLeft(4, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');
    final offset = dateTime.timeZoneOffset;
    final sign = offset.isNegative ? '-' : '+';
    final absoluteOffset = offset.abs();
    final offsetHour = absoluteOffset.inHours.toString().padLeft(2, '0');
    final offsetMinute = (absoluteOffset.inMinutes % 60).toString().padLeft(
      2,
      '0',
    );

    return '$year-$month-$day'
        'T$hour:$minute:$second$sign$offsetHour:$offsetMinute';
  }

  Widget _buildSleepFlowCard() {
    if (_sleepFlowPhase == _SleepFlowPhase.saving) {
      return const Center(child: StatusCardWidget(status: CardStatus.loading));
    }

    if (_sleepFlowPhase == _SleepFlowPhase.success) {
      return Center(
        child: StatusCardWidget(
          status: CardStatus.success,
          successTitle: 'Catatan tidur berhasil disimpan',
          successSubtitle: 'Data waktu tidur bayi telah tersimpan.',
          successButtonLabel: 'Lihat riwayat pencatatan',
          onSuccess: () => setState(() => _sleepFlowPhase = _SleepFlowPhase.none),
        ),
      );
    }

    if (_sleepFlowPhase == _SleepFlowPhase.error) {
      return Center(
        child: StatusCardWidget(
          status: CardStatus.error,
          errorTitle: 'Gagal menyimpan catatan tidur',
          errorSubtitle: _sleepErrorMessage ?? 'Terjadi kesalahan. Silahkan coba lagi.',
          errorButtonLabel: 'Lihat riwayat pencatatan',
          onError: () => setState(() {
            _sleepFlowPhase = _SleepFlowPhase.none;
            _sleepErrorMessage = null;
          }),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SleepBloc, SleepState>(
      listener: _onSleepStateChanged,
      child: _sleepFlowPhase != _SleepFlowPhase.none
          ? _buildSleepFlowCard()
          : _entries.isEmpty
              ? _notFoundSleepState()
              : _buildWithEntries(),
    );
  }

  Widget _notFoundSleepState() {
    final formattedDate =
        '${widget.selectedDate.day.toString().padLeft(2, '0')}-'
        '${widget.selectedDate.month.toString().padLeft(2, '0')}-'
        '${widget.selectedDate.year}';

    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: StaticColor.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: StaticColor.divider.withOpacity(0.5)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.nightlight_round,
              size: 40,
              color: Color(0xFF9CA3AF),
            ),
            const SizedBox(height: 16),
            Text(
              _isToday
                  ? 'Belum ada catatan tidur hari ini.'
                  : 'Data riwayat tidur tidak ditemukan',
              textAlign: TextAlign.center,
              style: AppTypography.h3.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              _isToday
                  ? 'Belum ada riwayat tidur yang tersimpan untuk hari ini.'
                  : 'Belum ada riwayat tidur yang tersimpan untuk tanggal $formattedDate.',
              textAlign: TextAlign.center,
              style: AppTypography.b3.copyWith(
                color: StaticColor.textMuted,
                height: 1.4,
              ),
            ),
            if (_isToday) ...[
              const SizedBox(height: 20),
              _buildAddNewButton(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWithEntries() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: StaticColor.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: StaticColor.divider.withOpacity(0.5)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Catatan Tidur Bayi Hari Ini',
              style: AppTypography.h3.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            if (_isToday) ...[
              _buildNotice(
                'Ibu dapat menambahkan catatan waktu tidur bayi '
                'sampai dengan maksimal $_maxEntries kali entri',
              ),
              const SizedBox(height: 12),
              Center(child: _buildAddNewButton()),
              const SizedBox(height: 12),
              Center(
                child: Container(width: 175, height: 1, color: StaticColor.divider),
              ),
            ],
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _entries.length,
                itemBuilder: (context, i) => _buildEntryCard(i),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewButton() {
    final atMax = _entries.length >= _maxEntries;
    return AppButton(
      label: 'Tambahkan catatan baru',
      onPressed: atMax ? null : _addNewEntry,
      height: 25,
      width: 190,
      borderRadius: 24,
      backgroundColor: StaticColor.primaryPink,
      foregroundColor: StaticColor.surface,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      leading: const Icon(
        Icons.add_circle_outline,
        color: StaticColor.surface,
        size: 16,
      ),
      textStyle: AppTypography.button2.copyWith(color: StaticColor.surface),
    );
  }

  Widget _buildEntryCard(int index) {
    final entry = _entries[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Entri ${index + 1}',
            style: AppTypography.h3.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: StaticColor.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: StaticColor.divider.withOpacity(0.5)),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.04),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: switch (entry.status) {
              _EntryStatus.form => _buildFormEntry(index, entry),
              _EntryStatus.active => _buildActiveEntry(index, entry),
              _EntryStatus.completed => _buildCompletedEntry(entry),
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormEntry(int index, _SleepEntry entry) {
    final hasStart = entry.start != null;
    final hasEnd = entry.end != null;
    final canSubmit = hasStart;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('Jam mulai tidur', style: AppTypography.b3),
                  const SizedBox(height: 8),
                  _buildTimeField(entry.start, () async {
                    final t = await _pickTime();
                    if (t != null && mounted) _updateEntryStart(index, t);
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(' : ', style: AppTypography.h3),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('Jam bangun', style: AppTypography.b3),
                  const SizedBox(height: 8),
                  _buildTimeField(entry.end, () async {
                    final t = await _pickTime();
                    if (t != null && mounted) _updateEntryEnd(index, t);
                  }),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppButton(
          label: hasStart && hasEnd
              ? 'Tambahkan entri'
              : 'Tambah waktu tidur bayi',
          onPressed: canSubmit ? () => _submitEntry(index) : null,
          height: 40,
          borderRadius: 24,
          backgroundColor: canSubmit
              ? StaticColor.primaryPink
              : StaticColor.divider,
          foregroundColor: canSubmit
              ? StaticColor.surface
              : StaticColor.textMuted,
          leading: Icon(
            hasStart && hasEnd ? Icons.check : Icons.add_box_outlined,
            color: canSubmit ? StaticColor.surface : StaticColor.textMuted,
            size: 16,
          ),
          textStyle: AppTypography.button2.copyWith(
            color: canSubmit ? StaticColor.surface : StaticColor.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveEntry(int index, _SleepEntry entry) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Jam mulai tidur', style: AppTypography.b3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(':', style: AppTypography.h3),
            ),
            _buildTimeChip(entry.start!),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: StaticColor.sleepingStatusBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Text('😴', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text(
                'Status: Bayi sedang tidur',
                style: AppTypography.b3.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        if (_isToday) ...[  
          const SizedBox(height: 12),
          AppButton(
            label: 'Tandai bayi sudah bangun',
            onPressed: () => _markAwake(index),
            height: 40,
            borderRadius: 24,
            backgroundColor: StaticColor.primaryPink,
            foregroundColor: StaticColor.surface,
            textStyle: AppTypography.button2.copyWith(color: StaticColor.surface),
          ),
        ],
      ],
    );
  }

  Widget _buildCompletedEntry(_SleepEntry entry) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('Jam mulai tidur', style: AppTypography.b3),
                  const SizedBox(height: 8),
                  _buildTimeChip(entry.start!),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(' : ', style: AppTypography.h3),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('Jam bangun', style: AppTypography.b3),
                  const SizedBox(height: 8),
                  _buildTimeChip(entry.end!),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: StaticColor.completedStatusBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: StaticColor.successGreen,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Catatan disimpan. Durasi tidur bayi: ',
                    style: AppTypography.b4.copyWith(
                      color: StaticColor.completedStatusText,
                    ),
                    children: [
                      TextSpan(
                        text: _formatDuration(entry.start!, entry.end!),
                        style: AppTypography.b4.copyWith(
                          color: StaticColor.completedStatusText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: AppTypography.b4.copyWith(
                          color: StaticColor.completedStatusText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotice(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: StaticColor.sleepNoticeBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: StaticColor.textMuted, width: 1.5),
            ),
            alignment: Alignment.center,
            child: Text(
              '!',
              style: AppTypography.detail.copyWith(
                color: StaticColor.textMuted,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTypography.b3.copyWith(color: StaticColor.textMuted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(TimeOfDay? time, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: StaticColor.primaryPink, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.access_time,
              color: StaticColor.primaryPink,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              time != null ? _formatTime(time) : '--:--',
              style: AppTypography.b3.copyWith(
                color: time != null
                    ? StaticColor.textPrimary
                    : StaticColor.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeChip(TimeOfDay time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: StaticColor.primaryPink, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.access_time,
            color: StaticColor.primaryPink,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            _formatTime(time),
            style: AppTypography.b3.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
