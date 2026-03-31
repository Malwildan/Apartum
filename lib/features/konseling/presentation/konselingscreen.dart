import 'package:apartum/core/global_widget/bottom_nav_widget.dart';
import 'package:apartum/core/global_widget/doctor_card_widget.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/konseling/presentation/cubit/konseling_cubit.dart';
import 'package:apartum/features/konseling/presentation/cubit/konseling_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Konselingscreen extends StatefulWidget {
  const Konselingscreen({super.key});

  @override
  State<Konselingscreen> createState() => _KonselingscreenState();
}

class _KonselingscreenState extends State<Konselingscreen> {
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<KonselingCubit>().fetchPsychologists();
    });
  }

  String _formatPrice(num priceIdr) {
    String sp = priceIdr.toString();
    sp = sp.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return 'Rp $sp';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konsultasi dengan Psikolog/Ahli', style: AppTypography.h2),
        backgroundColor: StaticColor.surface,
        centerTitle: true,
        elevation: 6,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBar: BottomNavWidget(
        selectedIndex: _selectedIndex,
        onItemTap: (index) {
          if (index == _selectedIndex) {
            return;
          }

          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/profile');
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        activeColor: StaticColor.primaryPink,
        inactiveColor: StaticColor.textMuted,
        backgroundColor: StaticColor.background,
        borderColor: StaticColor.divider,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Daftar Psikolog',
                  style: AppTypography.h2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<KonselingCubit, KonselingState>(
                builder: (context, state) {
                  if (state is KonselingLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is KonselingError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: AppTypography.b2Regular.copyWith(
                          color: StaticColor.textMuted,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (state is KonselingLoaded) {
                    final psychologists = state.psychologists;

                    if (psychologists.isEmpty) {
                      return Center(
                        child: Text(
                          'Belum ada psikolog tersedia.',
                          style: AppTypography.b2Regular.copyWith(
                            color: StaticColor.textMuted,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: psychologists.length,
                      itemBuilder: (context, index) {
                        final doctor = psychologists[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: DoctorCardWidget(
                            image: NetworkImage(doctor.photoUrl),
                            doctorName: doctor.name,
                            specializationAndExperience:
                                '${doctor.job} • ${doctor.experienceYears} Tahun Pengalaman',
                            priceText: _formatPrice(doctor.priceIdr),
                          ),
                        );
                      },
                    );
                  }

                  // Initial state or fallback
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
