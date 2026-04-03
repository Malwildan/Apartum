import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/features/homepage/presentation/bloc/homepage_bloc.dart';
import 'package:apartum/features/homepage/presentation/bloc/homepage_event.dart';
import 'package:apartum/features/homepage/presentation/bloc/homepage_state.dart';
import 'package:apartum/features/homepage/presentation/widgets/tanda_bahaya/tanda_bahaya_date_helper.dart';
import 'package:apartum/features/homepage/presentation/widgets/tanda_bahaya/tanda_bahaya_empty_state.dart';
import 'package:apartum/features/homepage/presentation/widgets/tanda_bahaya/tanda_bahaya_section_header.dart';
import 'package:apartum/features/homepage/presentation/widgets/tanda_bahaya/tanda_bahaya_symptom_card.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformasiTandaBahayaScreen extends StatefulWidget {
  const InformasiTandaBahayaScreen({super.key});

  @override
  State<InformasiTandaBahayaScreen> createState() =>
      _InformasiTandaBahayaScreenState();
}

class _InformasiTandaBahayaScreenState
    extends State<InformasiTandaBahayaScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<HomepageBloc>().add(const LoadHomepageEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3F8),
      appBar: AppBar(
        backgroundColor: StaticColor.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 3,
        shadowColor: Colors.black.withValues(alpha: 0.12),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: StaticColor.textPrimary,
        ),
        title: Text(
          'Informasi Tanda Bahaya',
          style: AppTypography.h2.copyWith(fontSize: 18.sp),
        ),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<HomepageBloc, HomepageState>(
          builder: (context, state) {
            final history = [
              if (state.todaySymptom != null &&
                  !state.symptomHistory
                      .any((s) => s.id == state.todaySymptom!.id))
                state.todaySymptom!,
              ...state.symptomHistory,
            ];

            if (history.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: const TandaBahayaEmptyState(),
              );
            }

            final grouped = <TandaBahayaSection, List<SymptomEntity>>{};
            for (final symptom in history) {
              final section = getTandaBahayaSection(symptom.date);
              grouped.putIfAbsent(section, () => []).add(symptom);
            }

            final items = <Widget>[];
            for (final section in TandaBahayaSection.values) {
              final symptoms = grouped[section];
              if (symptoms == null || symptoms.isEmpty) continue;
              items.add(TandaBahayaSectionHeader(
                label: getTandaBahayaSectionLabel(section),
              ));
              for (final symptom in symptoms) {
                items.add(TandaBahayaSymptomCard(symptom: symptom));
              }
            }

            return ListView.separated(
              padding: EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 32.h),
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (_, i) => items[i],
            );
          },
        ),
      ),
    );
  }
}