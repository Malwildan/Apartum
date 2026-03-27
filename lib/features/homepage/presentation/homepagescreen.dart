import 'package:apartum/core/global_widget/bottom_nav_widget.dart';
import 'package:apartum/features/homepage/presentation/widgets/baby_sleep_summary_widget.dart';
import 'package:apartum/features/homepage/presentation/widgets/daily_check_widget.dart';
import 'package:apartum/core/global_widget/doctor_card_widget.dart';
import 'package:apartum/core/global_data/doctor_data.dart';
import 'package:apartum/features/homepage/presentation/widgets/sleep_prediction_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: BottomNavWidget(
        selectedIndex: 0,
        centerIcon: Icons.child_care_rounded,
        centerLabel: 'Catat Gejala',
        items: const [
          BottomNavItemData(icon: Icons.home_rounded, label: 'Beranda'),
          BottomNavItemData(icon: Icons.history, label: 'Riwayat'),
          BottomNavItemData(
            icon: Icons.support_agent_rounded,
            label: 'Konseling',
          ),
          BottomNavItemData(icon: Icons.person_rounded, label: 'Profil'),
        ],
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
                  // Pink rounded rectangle background
                  Container(
                    height: 188,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF4D6D),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 44, bottom: 20),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xFFF1F1F1),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Halo, Ibu!',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
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
              //Center(child: BabySleepSummaryWidget()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 340),
                    Text(
                      'Insight hari ini',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF121212),
                      ),
                    ),
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
                        Text(
                          'Konsultasi Psikolog',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF121212),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Lihat Selengkapnya',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: const Color(0xFFFF4D6D),
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: const Color(0xFFFF4D6D),
                              ),
                            ),
                            //const SizedBox(width: 3),
                            const Icon(Icons.chevron_right, color: Color(0xFFFF4D6D), size: 18),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 140,
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
