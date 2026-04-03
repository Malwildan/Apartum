import 'package:apartum/core/global_widget/bottom_nav_widget.dart';
import 'package:apartum/core/global_widget/doctor_card_widget.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/homepage/domain/entities/summary_status.dart';
import 'package:apartum/features/homepage/presentation/bloc/homepage_bloc.dart';
import 'package:apartum/features/homepage/presentation/bloc/homepage_event.dart';
import 'package:apartum/features/homepage/presentation/bloc/homepage_state.dart';
import 'package:apartum/features/homepage/presentation/widgets/summary_widget.dart';
import 'package:apartum/features/homepage/presentation/widgets/daily_check_widget.dart';
import 'package:apartum/features/homepage/presentation/widgets/sleep_prediction_widget.dart';
import 'package:apartum/features/konseling/presentation/cubit/konseling_cubit.dart';
import 'package:apartum/features/konseling/presentation/cubit/konseling_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late final PageController _doctorPageController;

  @override
  void initState() {
    super.initState();
    _doctorPageController = PageController(viewportFraction: 0.78);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomepageBloc>().add(const LoadHomepageEvent());
      context.read<KonselingCubit>().fetchPsychologists();
    });
  }

  @override
  void dispose() {
    _doctorPageController.dispose();
    super.dispose();
  }

  SummaryStatus? _toSummaryStatus(String? level) {
    switch (level) {
      case 'safe':
        return SummaryStatus.safe;
      case 'warning':
        return SummaryStatus.warning;
      case 'danger':
        return SummaryStatus.danger;
      default:
        return null;
    }
  }

  String _formatPrice(num price) {
    String sp = price.toStringAsFixed(0);
    sp = sp.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return 'Rp $sp';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColor.surface,
      bottomNavigationBar: BottomNavWidget(
        selectedIndex: 0,
        onItemTap: (index) {
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/riwayat-catatan');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/konseling');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: BlocBuilder<HomepageBloc, HomepageState>(
          builder: (context, homepageState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 188,
                        decoration: BoxDecoration(
                          color: StaticColor.primaryPink,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 44, bottom: 20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: StaticColor.background,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Halo, ${homepageState.username ?? 'Ibu'}!',
                                style: AppTypography.h2.copyWith(
                                  color: StaticColor.surface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -320,
                        left: 20,
                        right: 20,
                        child: SummaryWidget(
                          summaryStatus: _toSummaryStatus(
                            homepageState.todaySymptom?.alert?.level,
                          ),
                          todaySymptom: homepageState.todaySymptom,
                          symptomHistory: homepageState.symptomHistory,
                          weeklySleep: homepageState.weeklySleep,
                          onStatusBannerTap: () {
                            Navigator.pushNamed(
                              context,
                              '/riwayat-catatan',
                              arguments: {'tabIndex': 0},
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 340),
                        Text('Insight hari ini', style: AppTypography.h2),
                        const SizedBox(height: 10),
                        SleepPredictionWidget(
                          todaySleep: homepageState.todaySleep,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/riwayat-catatan',
                              arguments: {'tabIndex': 1},
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        DailyCheckWidget(
                          isLogged: homepageState.todaySymptom != null,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/riwayat-catatan',
                              arguments: {'tabIndex': 0},
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Konsultasi Psikolog',
                              style: AppTypography.h2,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/konseling');
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Lihat Selengkapnya',
                                    style: AppTypography.h4.copyWith(
                                      color: StaticColor.primaryPink,
                                      decoration: TextDecoration.underline,
                                      decorationColor: StaticColor.primaryPink,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: StaticColor.primaryPink,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<KonselingCubit, KonselingState>(
                    builder: (context, konselingState) {
                      if (konselingState is! KonselingLoaded) {
                        return const SizedBox(height: 144);
                      }
                      final doctors = konselingState.psychologists;
                      return SizedBox(
                        height: 144,
                        child: PageView.builder(
                          controller: _doctorPageController,
                          itemCount: doctors.length,
                          itemBuilder: (context, index) {
                            final doctor = doctors[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                bottom: 8,
                              ),
                              child: DoctorCardWidget(
                                image: NetworkImage(doctor.photoUrl),
                                doctorName: doctor.name,
                                specializationAndExperience:
                                    '${doctor.job} · ${doctor.experienceYears} tahun',
                                priceText: _formatPrice(doctor.priceIdr),
                                onBookingTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/konseling-detail',
                                    arguments: doctor.id,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
