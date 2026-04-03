import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/global_widget/status_card_widget.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/konseling/domain/entities/schedule_entity.dart';
import 'package:apartum/features/konseling/presentation/bloc/konseling_detail_bloc.dart';
import 'package:apartum/features/konseling/presentation/bloc/konseling_detail_event.dart';
import 'package:apartum/features/konseling/presentation/bloc/konseling_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KonselingDetailScreen extends StatefulWidget {
  const KonselingDetailScreen({super.key});

  @override
  State<KonselingDetailScreen> createState() => _KonselingDetailScreenState();
}

class _KonselingDetailScreenState extends State<KonselingDetailScreen> {
  ScheduleEntity? selectedSchedule;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final id = ModalRoute.of(context)?.settings.arguments as String?;
      if (id != null) {
        context
            .read<KonselingDetailBloc>()
            .add(FetchPsychologistDetailEvent(id));
      }
      _isInit = true;
    }
  }

  Widget _buildTimeSlot(ScheduleEntity schedule) {
    bool isSelected =
        selectedSchedule == schedule ||
        (selectedSchedule?.label == schedule.label);
    final timeRange = '${schedule.startTime}–${schedule.endTime}';
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSchedule = schedule;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? StaticColor.primaryPink : Colors.transparent,
          border: Border.all(color: StaticColor.primaryPink, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          timeRange,
          style: AppTypography.b2.copyWith(
            color: isSelected ? StaticColor.surface : StaticColor.primaryPink,
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleDisplay(List<ScheduleEntity>? schedules) {
    if (schedules == null || schedules.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Text(
          'Jadwal tidak tersedia pada saat ini.',
          style: AppTypography.b2Regular.copyWith(color: StaticColor.textMuted),
        ),
      );
    }

    // Group schedules by dayOfWeek
    final groupedSchedules = <String, List<ScheduleEntity>>{};
    for (var schedule in schedules) {
      groupedSchedules.putIfAbsent(schedule.dayOfWeek, () => []).add(schedule);
    }

    final children = <Widget>[];
    int index = 0;
    for (var entry in groupedSchedules.entries) {
      children.add(Text(entry.key, style: AppTypography.b2));
      children.add(const SizedBox(height: 12));
      children.add(
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: entry.value.map((schedule) {
            return _buildTimeSlot(schedule);
          }).toList(),
        ),
      );
      if (index < groupedSchedules.length - 1) {
        children.add(const SizedBox(height: 20));
        children.add(const Divider(color: StaticColor.divider));
        children.add(const SizedBox(height: 20));
      }
      index++;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColor.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Konsultasi dengan Psikolog/Ahli', style: AppTypography.h2),
        backgroundColor: StaticColor.surface,
        centerTitle: true,
        elevation: 4,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.1),
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: StaticColor.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: StaticColor.divider.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jadwal Dokter', style: AppTypography.h3),
              const SizedBox(height: 4),
              Text(
                'Mohon untuk melihat terlebih dahulu ketersediaan atau jadwal dari dokter yang Anda pilih',
                style: AppTypography.b3Regular.copyWith(
                  color: StaticColor.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              BlocBuilder<KonselingDetailBloc, KonselingDetailState>(
                builder: (context, state) {
                  if (state is KonselingDetailLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is KonselingDetailError) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Text(
                          state.message,
                          style: AppTypography.b2Regular.copyWith(
                            color: StaticColor.errorRed,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else if (state is KonselingDetailLoaded) {
                    return _buildScheduleDisplay(state.psychologist.schedules);
                  }
                  return const SizedBox(
                    height: 80,
                  ); // Provide some space for initial state
                },
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  label: "Lanjutkan",
                  trailing: Icon(Icons.arrow_forward),
                  onPressed: selectedSchedule == null
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) => StatusCardWidget(
                              status: CardStatus.whatsappBooking,
                              onSuccess: () {
                                print('a');
                              },
                            ),
                          );
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
