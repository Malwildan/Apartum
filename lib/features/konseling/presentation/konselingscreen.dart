import 'package:apartum/core/global_data/doctor_data.dart';
import 'package:apartum/core/global_widget/bottom_nav_widget.dart';
import 'package:apartum/core/global_widget/doctor_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Konselingscreen extends StatefulWidget {
  const Konselingscreen({super.key});

  @override
  State<Konselingscreen> createState() => _KonselingscreenState();
}

class _KonselingscreenState extends State<Konselingscreen> {
  int _selectedIndex = 2; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konsultasi dengan Psikolog/Ahli', style: GoogleFonts.plusJakartaSans(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        elevation: 6,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBar: BottomNavWidget(
        items: const [
          BottomNavItemData(icon: Icons.home_rounded, label: 'Beranda'),
          BottomNavItemData(icon: Icons.history, label: 'Riwayat'),
          BottomNavItemData(
            icon: Icons.support_agent_rounded,
            label: 'Konseling',
          ),
          BottomNavItemData(icon: Icons.person_rounded, label: 'Profil'),
        ],
        selectedIndex: _selectedIndex,
        onItemTap: (index) {
          if (index == _selectedIndex) {
            return;
          }

          // Handle navigation only when changing page.
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
        onCenterTap: () {
          // Handle center button tap (Catat Gejala)
        },
        centerIcon: Icons.child_care_rounded,
        centerLabel: 'Catat Gejala',
        activeColor: const Color(0xFFFF4D6D),
        inactiveColor: const Color(0xFF8E8E8E),
        backgroundColor: const Color(0xFFFAFAFA),
        borderColor: const Color(0xFFE0E0E0),
      ),
      body:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Daftar Psikolog', style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    ), textAlign: TextAlign.center,),
                  ],
                ),
                SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: doctorsData.length,
                    itemBuilder: (context, index){
                      final doctor = doctorsData[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: DoctorCardWidget(
                          image: AssetImage(doctor.imagePath),
                          doctorName: doctor.doctorName,
                          specializationAndExperience: doctor.specializationAndExperience,
                          priceText: doctor.priceText,
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        
      );
  }
}
