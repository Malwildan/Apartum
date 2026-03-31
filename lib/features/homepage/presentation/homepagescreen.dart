import 'package:apartum/core/global_widget/bottom_nav_widget.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/homepage/presentation/widgets/baby_sleep_summary_widget.dart';
import 'package:apartum/features/homepage/presentation/widgets/daily_check_widget.dart';
import 'package:apartum/core/global_widget/doctor_card_widget.dart';
import 'package:apartum/core/global_data/doctor_data.dart';
import 'package:apartum/features/homepage/presentation/widgets/sleep_prediction_widget.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  void dispose() {
    _doctorPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColor.surface,
      bottomNavigationBar: BottomNavWidget(
        selectedIndex: 0,
        onItemTap: (index) {
          if (index == 2) {
            Navigator.pushReplacementNamed(context, '/konseling');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
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
                            'Halo, Ibu!',
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
                    child: BabySleepSummaryWidget(),
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
                    const SleepPredictionWidget(
                      message: 'Bayi akan bangun pada sekitar pukul 14.05 WIB',
                    ),
                    const SizedBox(height: 10),
                    DailyCheckWidget(
                      message:
                          'Yuk catat kondisi dan gejala yang dialami hari ini, pencatatan hanya membutuhkan waktu kurang dari 1 menit😊',
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Konsultasi Psikolog', style: AppTypography.h2),
                        Row(
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
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 144,
                child: PageView.builder(
                  controller: _doctorPageController,
                  itemCount: doctorsData.length,
                  itemBuilder: (context, index) {
                    final doctor = doctorsData[index];

                    return Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 8),
                      child: DoctorCardWidget(
                        image: AssetImage(doctor.imagePath),
                        doctorName: doctor.doctorName,
                        specializationAndExperience:
                            doctor.specializationAndExperience,
                        priceText: doctor.priceText,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
