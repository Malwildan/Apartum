import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:apartum/core/global_widget/bottom_nav_widget.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_bloc.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_event.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_state.dart';
import 'package:apartum/features/riwayat_catatan/presentation/riwayat_gejala_screen.dart';
import 'package:apartum/features/riwayat_catatan/presentation/riwayat_tidur_bayi_screen.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/riwayat_calendar_widget.dart';
import 'package:apartum/features/riwayat_catatan/presentation/widgets/riwayat_tabs_widget.dart';

class RiwayatCatatanScreen extends StatefulWidget {
  const RiwayatCatatanScreen({super.key, this.initialTabIndex = 0});

  final int initialTabIndex;

  @override
  State<RiwayatCatatanScreen> createState() => _RiwayatCatatanScreenState();
}

class _RiwayatCatatanScreenState extends State<RiwayatCatatanScreen> {
  static const int _selectedIndex = 1;

  late int _activeTab;

  @override
  void initState() {
    super.initState();
    _activeTab = widget.initialTabIndex.clamp(0, 1);
  }

  void _onBottomNavTap(int index) {
    const routes = ['/home', '/riwayat-catatan', '/konseling', '/profile'];
    if (index >= 0 && index < routes.length) {
      Navigator.pushReplacementNamed(context, routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColor.background,
      appBar: AppBar(
        title: Text('Riwayat Pencatatan', style: AppTypography.h2),
        centerTitle: true,
        backgroundColor: StaticColor.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBar: BottomNavWidget(
        selectedIndex: _selectedIndex,
        onItemTap: _onBottomNavTap,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: BlocBuilder<SymptomBloc, SymptomState>(
            builder: (context, symptomState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  _buildCalendar(symptomState),
                  SizedBox(height: 24.h),
                  RiwayatTabsWidget(
                    activeIndex: _activeTab,
                    onTap: (index) => setState(() => _activeTab = index),
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: _activeTab == 0
                        ? RiwayatGejalaScreen(
                            selectedDate: symptomState.selectedDate,
                          )
                        : RiwayatTidurBayiScreen(
                            selectedDate: symptomState.selectedDate,
                          ),
                  ),
                  SizedBox(height: 20.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar(SymptomState symptomState) {
    return RiwayatCalendarWidget(
      selectedDate: symptomState.selectedDate,
      focusedDay: symptomState.focusedDay,
      onDaySelected: (selectedDay, focusedDay) {
        context.read<SymptomBloc>().add(
              SelectDateEvent(
                selectedDate: selectedDay,
                focusedDay: focusedDay,
              ),
            );
      },
      onPageChanged: (focusedDay) {
        context.read<SymptomBloc>().add(ChangeMonthEvent(focusedDay));
      },
    );
  }
}
