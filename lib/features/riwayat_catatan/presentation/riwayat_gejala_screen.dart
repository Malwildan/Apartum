import 'package:apartum/core/global_widget/status_card_widget.dart';
import 'package:apartum/features/riwayat_catatan/data/models/symptom_mapper.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_entity.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_bloc.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_event.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_state.dart';
import 'package:apartum/features/riwayat_catatan/presentation/riwayat_catatan_answer_data.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/bagian_1_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/bagian_2_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/bagian_3_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/riwayat_info_banner_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/riwayat_recap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum _SaveFlowPhase { none, saving, saved, alertResult }

class RiwayatGejalaScreen extends StatefulWidget {
  final DateTime selectedDate;

  const RiwayatGejalaScreen({super.key, required this.selectedDate});

  @override
  State<RiwayatGejalaScreen> createState() => _RiwayatGejalaScreenState();
}

class _RiwayatGejalaScreenState extends State<RiwayatGejalaScreen> {
  int _currentStep = 1;
  String? _syncedDate;
  _SaveFlowPhase _saveFlowPhase = _SaveFlowPhase.none;

  Bagian1AnswerData? _bagian1Data;
  Bagian2AnswerData? _bagian2Data;
  Bagian3AnswerData? _bagian3Data;

  bool get _isSelectedDateToday {
    final now = DateTime.now();
    return widget.selectedDate.year == now.year &&
        widget.selectedDate.month == now.month &&
        widget.selectedDate.day == now.day;
  }

  void _resetLocalAnswers() {
    _currentStep = 1;
    _bagian1Data = null;
    _bagian2Data = null;
    _bagian3Data = null;
    _syncedDate = null;
    _saveFlowPhase = _SaveFlowPhase.none;
  }

  void _syncFromDetail(SymptomEntity detail) {
    final bundle = SymptomMapper.toAnswerData(detail);
    _bagian1Data = bundle.bagian1;
    _bagian2Data = bundle.bagian2;
    _bagian3Data = bundle.bagian3;
    _currentStep = 4;
    _syncedDate = detail.date;
  }

  void _saveRecapChanges() {
    if (_bagian1Data == null || _bagian2Data == null || _bagian3Data == null) {
      return;
    }

    final request = SymptomMapper.fromAnswerData(
      selectedDate: widget.selectedDate,
      bagian1: _bagian1Data!,
      bagian2: _bagian2Data!,
      bagian3: _bagian3Data!,
    );

    setState(() => _saveFlowPhase = _SaveFlowPhase.saving);
    context.read<SymptomBloc>().add(SaveSymptomEvent(request));
  }

  String _formatDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  Widget _buildSaveFlowCard(BuildContext context, SymptomState state) {
    if (_saveFlowPhase == _SaveFlowPhase.saving) {
      return const Center(child: StatusCardWidget(status: CardStatus.loading));
    }

    if (_saveFlowPhase == _SaveFlowPhase.saved) {
      return Center(
        child: StatusCardWidget(
          status: CardStatus.success,
          successTitle: 'Data berhasil disimpan',
          successSubtitle: 'Lihat hasil analisis gejala yang Anda catat.',
          successButtonLabel: 'Lihat Hasil Analisis',
          onSuccess: () =>
              setState(() => _saveFlowPhase = _SaveFlowPhase.alertResult),
        ),
      );
    }

    if (_saveFlowPhase == _SaveFlowPhase.alertResult) {
      final alert = state.symptomDetail?.alert;
      if (alert == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => _saveFlowPhase = _SaveFlowPhase.none);
        });
        return const SizedBox.shrink();
      }

      final issues = alert.issues
          .map((i) => AlertIssueData(disease: i.disease, symptoms: i.symptoms))
          .toList();

      final cardStatus = switch (alert.level) {
        'safe' => CardStatus.safe,
        'warning' => CardStatus.warning,
        'danger' => CardStatus.danger,
        _ => CardStatus.safe,
      };

      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: StatusCardWidget(
            status: cardStatus,
            alertIssues: issues,
            onSuccess: () =>
                setState(() => _saveFlowPhase = _SaveFlowPhase.none),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  void initState() {
    super.initState();
    // Immediately sync from any already-loaded state so switching back
    // to this tab shows the recap without waiting for a round-trip.
    final currentDetail = context.read<SymptomBloc>().state.symptomDetail;
    if (currentDetail != null) {
      _syncFromDetail(currentDetail);
    }
    // Always fetch fresh data as well.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<SymptomBloc>().add(
        FetchSymptomDetailEvent(_formatDate(widget.selectedDate)),
      );
    });
  }

  @override
  void didUpdateWidget(covariant RiwayatGejalaScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldDate = DateTime(
      oldWidget.selectedDate.year,
      oldWidget.selectedDate.month,
      oldWidget.selectedDate.day,
    );
    final newDate = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
    );

    if (oldDate != newDate) {
      final currentDetail = context.read<SymptomBloc>().state.symptomDetail;
      setState(() {
        _resetLocalAnswers();
        if (currentDetail != null) {
          _syncFromDetail(currentDetail);
        }
      });
      // Only fetch if there's no data already in state (non-today dates are
      // already being fetched by SelectDateEvent in the bloc).
      if (currentDetail == null) {
        context.read<SymptomBloc>().add(
          FetchSymptomDetailEvent(_formatDate(widget.selectedDate)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SymptomBloc, SymptomState>(
      listener: (context, state) {
        if (state.status == SymptomStatus.error && state.errorMessage != null) {
          if (_saveFlowPhase != _SaveFlowPhase.none) {
            setState(() => _saveFlowPhase = _SaveFlowPhase.none);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }

        if (state.status == SymptomStatus.saved) {
          if (_saveFlowPhase == _SaveFlowPhase.saving) {
            setState(() => _saveFlowPhase = _SaveFlowPhase.saved);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gejala berhasil disimpan.')),
            );
          }
        }

        if (state.status == SymptomStatus.empty) {
          setState(_resetLocalAnswers);
        }

        final detail = state.symptomDetail;
        if (detail != null && detail.date != _syncedDate) {
          setState(() => _syncFromDetail(detail));
        }
      },
      builder: (context, state) {
        if (state.status == SymptomStatus.loading ||
            (state.status == SymptomStatus.saving &&
                _saveFlowPhase == _SaveFlowPhase.none)) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (_saveFlowPhase != _SaveFlowPhase.none) {
          return _buildSaveFlowCard(context, state);
        }

        final hasRecap =
            _bagian1Data != null && _bagian2Data != null && _bagian3Data != null && _currentStep == 4;
        final showEmptyState = state.status == SymptomStatus.empty && !_isSelectedDateToday;

        return Column(
          children: [
            if (_isSelectedDateToday) ...[
              RiwayatInfoBannerWidget(
                variant: hasRecap
                    ? RiwayatInfoBannerVariant.done
                    : RiwayatInfoBannerVariant.defaultBanner,
              ),
              const SizedBox(height: 20),
            ],
            Expanded(
              child: showEmptyState
                  ? _NotFoundSymptomWidget(selectedDate: widget.selectedDate)
                  : switch (_currentStep) {
                1 => Bagian1Widget(
                    onNext: (data) => setState(() {
                      _bagian1Data = data;
                      _currentStep = 2;
                    }),
                  ),
                2 => Bagian2Widget(
                    onBack: () => setState(() => _currentStep = 1),
                    onNext: (data) => setState(() {
                      _bagian2Data = data;
                      _currentStep = 3;
                    }),
                  ),
                3 => Bagian3Widget(
                    onBack: () => setState(() => _currentStep = 2),
                    onSave: (data) {
                      if (_bagian1Data == null || _bagian2Data == null) {
                        return;
                      }

                      setState(() {
                        _bagian3Data = data;
                        _saveFlowPhase = _SaveFlowPhase.saving;
                      });

                      final request = SymptomMapper.fromAnswerData(
                        selectedDate: widget.selectedDate,
                        bagian1: _bagian1Data!,
                        bagian2: _bagian2Data!,
                        bagian3: data,
                      );

                      context.read<SymptomBloc>().add(SaveSymptomEvent(request));
                    },
                  ),
                _ when _bagian1Data != null && _bagian2Data != null && _bagian3Data != null =>
                  RiwayatRecapWidget(
                    bagian1: _bagian1Data!,
                    bagian2: _bagian2Data!,
                    bagian3: _bagian3Data!,
                    isEditable: _isSelectedDateToday,
                    onBagian1Changed: _isSelectedDateToday
                        ? (value) => setState(() => _bagian1Data = value)
                        : null,
                    onBagian2Changed: _isSelectedDateToday
                        ? (value) => setState(() => _bagian2Data = value)
                        : null,
                    onBagian3Changed: _isSelectedDateToday
                        ? (value) => setState(() => _bagian3Data = value)
                        : null,
                    onConfirm: _isSelectedDateToday ? _saveRecapChanges : null,
                  ),
                _ => const SizedBox.shrink(),
              },
            ),
          ],
        );
      },
    );
  }
}

class _NotFoundSymptomWidget extends StatelessWidget {
  final DateTime selectedDate;

  const _NotFoundSymptomWidget({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        '${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}';

    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE8E8E8)),
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
              Icons.event_note_rounded,
              size: 40,
              color: Color(0xFF9CA3AF),
            ),
            const SizedBox(height: 16),
            Text(
              'Data gejala tidak ditemukan',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Belum ada riwayat gejala yang tersimpan untuk tanggal $formattedDate.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF6B7280),
                    height: 1.4,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}