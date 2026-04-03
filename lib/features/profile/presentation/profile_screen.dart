import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:apartum/features/profile/presentation/widgets/profile_row_widget.dart';
import 'package:apartum/features/profile/presentation/widgets/preference_row_widget.dart';
import 'package:apartum/core/global_widget/bottom_nav_widget.dart';
import 'package:apartum/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:apartum/features/auth/presentation/bloc/auth_event.dart';
import 'package:apartum/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:apartum/features/profile/presentation/bloc/profile_event.dart';
import 'package:apartum/features/profile/presentation/bloc/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
  
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(const FetchProfileEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColor.background,
      bottomNavigationBar: BottomNavWidget(
        selectedIndex: _selectedIndex,
        onItemTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/riwayat-catatan');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/konseling');
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          String name = 'Memuat...';
          String email = '-';
          String birthDate = '-';

          if (state is ProfileLoaded || state is ProfileUpdateSuccess) {
            final profile = state is ProfileLoaded
                ? state.profile
                : (state as ProfileUpdateSuccess).profile;

            name = profile.name;
            email = profile.email;
            birthDate = profile.birthDate;
          } else if (state is ProfileError) {
            name = 'Gagal Memuat';
          }

          return Stack(
            children: [
              Column(
                children: [
                  HeaderSection(),

                  const SizedBox(height: 60),

                  Text(
                    name,
                    style: AppTypography.h1.copyWith(
                      color: StaticColor.textPrimary,
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
                                Text('Detail Profil', style: AppTypography.h3),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/edit-profile',
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 24,
                                    color: StaticColor.textPrimary,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: StaticColor.surface,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  ProfileRowWidget(
                                    icon: Icons.mail_outline_rounded,
                                    label: 'Email',
                                    value: email,
                                  ),

                                  const SizedBox(height: 18),
                                  Divider(
                                    height: 1,
                                    color: StaticColor.divider,
                                  ),
                                  const SizedBox(height: 22),

                                  ProfileRowWidget(
                                    icon: Icons.person_2_outlined,
                                    label: 'Username',
                                    value: name,
                                  ),

                                  const SizedBox(height: 18),
                                  Divider(
                                    height: 1,
                                    color: StaticColor.divider,
                                  ),
                                  const SizedBox(height: 22),

                                  ProfileRowWidget(
                                    icon: Icons.calendar_month_outlined,
                                    label: 'Tanggal Persalinan',
                                    value: birthDate,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 28),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Preferensi', style: AppTypography.h3),
                              ],
                            ),

                            const SizedBox(height: 20),

                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: StaticColor.surface,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  PreferenceRowWidget(
                                    icon: Icons.notifications_none_outlined,
                                    label: 'Atur Notifikasi',
                                  ),

                                  const SizedBox(height: 20),
                                  Divider(
                                    height: 1,
                                    color: StaticColor.divider,
                                  ),
                                  const SizedBox(height: 22),

                                  PreferenceRowWidget(
                                    icon: Icons.lock_outline_rounded,
                                    label: 'Ubah Kata Sandi',
                                  ),

                                  const SizedBox(height: 20),
                                  Divider(
                                    height: 1,
                                    color: StaticColor.divider,
                                  ),
                                  const SizedBox(height: 24),

                                  InkWell(
                                    onTap: () {
                                      context.read<AuthBloc>().add(const LogoutEvent());
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/login',
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.logout_rounded,
                                          size: 18,
                                          color: StaticColor.destructive,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'Keluar',
                                          style: AppTypography.b2.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: StaticColor.destructive,
                                          ),
                                        ),
                                      ],
                                    ),
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
          );
        },
      ),
    );
  }

}
