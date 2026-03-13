import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apartum/screen/auth/register.dart';
import 'package:apartum/widget/app_button.dart';
import 'package:apartum/widget/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 52, 16, 52),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Login',
                  style: GoogleFonts.lexend(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                    color: const Color(0xFFFA4C75),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Email',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E1E1E),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              AppTextField(
                hintText: 'Masukan Email',
                keyboardType: TextInputType.emailAddress,
                textStyle: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF1E1E1E),
                ),
                hintStyle: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF8A8A8A),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Kata Sandi',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E1E1E),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              AppTextField(
                hintText: 'Masukan Kata Sandi',
                obscureText: true,
                textStyle: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF1E1E1E),
                ),
                hintStyle: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF8A8A8A),
                ),
              ),
              const SizedBox(height: 35),
              AppButton(
                width: double.infinity,
                label: 'Masuk',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                textStyle: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 36),
              Center(
                child: Text(
                  'atau',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF1E1E1E),
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Belum punya akun? ',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Daftar',
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFC00044),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
