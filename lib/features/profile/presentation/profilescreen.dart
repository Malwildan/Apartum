import 'package:apartum/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:apartum/core/global_widget/bottom_nav_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
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

         
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/konseling');
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        onCenterTap: () {
          
        },
        centerIcon: Icons.child_care_rounded,
        centerLabel: 'Catat Gejala',
        activeColor: const Color(0xFFFF4D6D),
        inactiveColor: const Color(0xFF8E8E8E),
        backgroundColor: const Color(0xFFFAFAFA),
        borderColor: const Color(0xFFE0E0E0),
      ),
      body: Stack(
        children: [
          
          Column(
            children: [
              HeaderSection(),

              const SizedBox(height: 60),

              Text(
                'Wildatus Sakinah',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF121212),
                ),
              ),

              const SizedBox(height: 28),

              
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Detail Profil',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF121212),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/edit-profile');
                              }, // Handle edit profile tap
                              child: const Icon(
                                Icons.edit_outlined,
                                size: 24,
                                color: Color(0xFF121212),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.mail_outline_rounded,
                                    size: 18,
                                    color: Color(0xFF4B4B4B),
                                  ),
                                  const SizedBox(width: 14),
                                  Text(
                                    'Email',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF121212),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'wildatussakinah@gmail.com',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF121212),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 18),
                              const Divider(
                                height: 1,
                                color: Color(0xFFD3D5DC),
                              ),
                              const SizedBox(height: 22),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.person_2_outlined,
                                    size: 18,
                                    color: Color(0xFF4B4B4B),
                                  ),
                                  const SizedBox(width: 14),
                                  Text(
                                    'Username',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF121212),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'wildatussa_9',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF121212),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 18),
                              const Divider(
                                height: 1,
                                color: Color(0xFFD3D5DC),
                              ),
                              const SizedBox(height: 22),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                    size: 18,
                                    color: Color(0xFF4B4B4B),
                                  ),
                                  const SizedBox(width: 14),
                                  Text(
                                    'Tanggal Persalinan',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF121212),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '09-02-2026',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF121212),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 28),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Preferensi',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF121212),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.notifications_none_outlined,
                                    size: 18,
                                    color: Color(0xFF4B4B4B),
                                  ),
                                  const SizedBox(width: 14),
                                  Text(
                                    'Atur Notifikasi',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF121212),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    size: 18,
                                    color: Color(0xFF121212),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),
                              const Divider(
                                height: 1,
                                color: Color(0xFFD3D5DC),
                              ),
                              const SizedBox(height: 22),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.lock_outline_rounded,
                                    size: 18,
                                    color: Color(0xFF4B4B4B),
                                  ),
                                  const SizedBox(width: 14),
                                  Text(
                                    'Ubah Kata Sandi',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF121212),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    size: 18,
                                    color: Color(0xFF121212),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),
                              const Divider(
                                height: 1,
                                color: Color(0xFFD3D5DC),
                              ),
                              const SizedBox(height: 24),

                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/login',
                                      );
                                    },
                                    child: const Icon(
                                      Icons.logout_rounded,
                                      size: 18,
                                      color: Color(0xFFFF3B30),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Keluar',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFFFF3B30),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
