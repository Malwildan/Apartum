import 'package:apartum/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apartum/widget/app_button.dart';
import 'package:apartum/widget/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _deliveryDateController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _deliveryDateController.dispose();
    super.dispose();
  }

  Future<void> _pickDeliveryDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate == null) {
      return;
    }

    final String formatted =
        '${pickedDate.day.toString().padLeft(2, '0')}/'
        '${pickedDate.month.toString().padLeft(2, '0')}/'
        '${pickedDate.year}';
    _deliveryDateController.text = formatted;
  }

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
                  'Register',
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
                'Nama Pengguna',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E1E1E),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              AppTextField(
                hintText: 'Masukan Nama Ibu',
                keyboardType: TextInputType.name,
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
                'Tanggal Persalinan',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E1E1E),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              AppTextField(
                hintText: 'Masukkan Tanggal Persalinan',
                controller: _deliveryDateController,
                readOnly: true,
                onTap: _pickDeliveryDate,
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
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF555555),
                  ),
                ),
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
                'Konfirmasi Kata Sandi',
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
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF555555),
                  ),
                ),
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
                label: 'Daftar',
                onPressed: () {},
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
                      'Sudah punya akun? ',
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Masuk',
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