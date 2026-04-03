import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/features/riwayat_catatan/data/models/symptom_mapper.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/riwayat_catatan_answer_data.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_entity.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_bloc.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_event.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_state.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/bagian_1_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/bagian_2_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/bagian_3_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/gejala/gejala_widgets.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/riwayat_info_banner_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/riwayat_recap_widget.dart';

class RiwayatGejalaScreen extends StatefulWidget {
  final DateTime selectedDate;

  const RiwayatGejalaScreen({super.key, required this.selectedDate});

  @override
  State<RiwayatGejalaScreen> createState() => _RiwayatGejalaScreenState();
}

class _RiwayatGejalaScreenState extends State<RiwayatGejalaScreen> {
  int _currentStep = 1;
  String? _syncedDate;
  SaveFlowPhase _saveFlowPhase = SaveFlowPhase.none;

  Bagian1AnswerData? _bagian1Data;
  Bagian2AnswerData? _bagian2Data;
  Bagian3AnswerData? _bagian3Data;

  bool get _isSelectedDateToday => GejalaHelpers.isToday(widget.selectedDate);

  void _resetLocalAnswers() {
    _currentStep = 1;
    _bagian1Data = null;
    _bagian2Data = null;
    _bagian3Data = null;
    _syncedDate = null;
    _saveFlowPhase = SaveFlowPhase.none;
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
    setState(() => _saveFlowPhase = SaveFlowPhase.saving);
    context.read<SymptomBloc>().add(SaveSymptomEvent(request));
  }

  @override
  void initState() {
    super.initState();
    final currentDetail = context.read<SymptomBloc>().state.symptomDetail;
    if (currentDetail != null) {
      _syncFromDetail(currentDetail);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<SymptomBloc>().add(
        FetchSymptomDetailEvent(GejalaHelpers.formatDate(widget.selectedDate)),
      );
    });
  }

  @override
  void didUpdateWidget(covariant RiwayatGejalaScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final isSameDay = oldWidget.selectedDate.year == widget.selectedDate.year &&
        oldWidget.selectedDate.month == widget.selectedDate.month &&
        oldWidget.selectedDate.day == widget.selectedDate.day;

    if (!isSameDay) {
      final currentDetail = context.read<SymptomBloc>().state.symptomDetail;
      setState(() {
        _resetLocalAnswers();
        if (currentDetail != null) _syncFromDetail(currentDetail);
      });
      if (currentDetail == null) {
        context.read<SymptomBloc>().add(
          FetchSymptomDetailEvent(GejalaHelpers.formatDate(widget.selectedDate)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SymptomBloc, SymptomState>(
      listener: (context, state) {
        if (state.status == SymptomStatus.error && state.errorMessage != null) {
          if (_saveFlowPhase != SaveFlowPhase.none) {
            setState(() => _saveFlowPhase = SaveFlowPhase.none);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }

        if (state.status == SymptomStatus.saved) {
          if (_saveFlowPhase == SaveFlowPhase.saving) {
            setState(() => _saveFlowPhase = SaveFlowPhase.saved);
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
                _saveFlowPhase == SaveFlowPhase.none)) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (_saveFlowPhase != SaveFlowPhase.none) {
          return SaveFlowCard(
            phase: _saveFlowPhase,
            state: state,
            onResultDismiss: () => setState(() => _saveFlowPhase = SaveFlowPhase.none),
            onSavedContinue: () => setState(() => _saveFlowPhase = SaveFlowPhase.alertResult),
          );
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
              SizedBox(height: 20.h),
            ],
            Expanded(
              child: showEmptyState
                  ? NotFoundSymptomWidget(selectedDate: widget.selectedDate)
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
                        _saveFlowPhase = SaveFlowPhase.saving;
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