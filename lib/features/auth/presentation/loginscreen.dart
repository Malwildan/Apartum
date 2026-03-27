import 'package:apartum/core/global_widget/button.dart';
import 'package:apartum/core/global_widget/inputfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final Listenable _submitListenable = Listenable.merge([
    _emailController,
    _passwordController,
  ]);

  bool _obscurePassword = true;

  bool get _canSubmit {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    return email.isNotEmpty && password.isNotEmpty;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFF7F7FB);
    const Color primaryPink = Color(0xFFFF4B6E);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            padding: EdgeInsets.fromLTRB(20,16,20,87,),
            children: [
              Row(
				mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: const Color.fromARGB(0, 34, 34, 34),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Masuk',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: primaryPink,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              AppInputField(
                label: 'Email',
                hintText: 'Masukkan Email Anda',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                leading: const Icon(
                  Icons.email_outlined,
                  color: Color(0xFF6A6A6A),
                  size: 24,
                ),
                trailing: const SizedBox.shrink(),
                statusText: 'Gunakan email berakhiran @gmail.com',
                state: AppInputFieldState.normal,
                hideHintOnFocus: true,
                borderRadius: 18,
              ),
              const SizedBox(height: 26),
              AppInputField(
                label: 'Kata Sandi',
                hintText: 'Masukkan Kata Sandi',
                controller: _passwordController,
                obscureText: _obscurePassword,
                hideHintOnFocus: true,
                leading: const Icon(
                  Icons.lock_outline_rounded,
                  color: Color(0xFF6A6A6A),
                  size: 24,
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 24,
                  ),
                ),
                statusText:
                    'Buat kata sandi minimal 8 karakter dengan kombinasi huruf dan angka',
                state: AppInputFieldState.normal,
                borderRadius: 18,
              ),
              const SizedBox(height: 32),
              AnimatedBuilder(
                animation: _submitListenable,
                builder: (context, _) {
                  return AppButton(
                    label: 'Masuk',
                    onPressed: _canSubmit ? () {
                      Navigator.of(context).pushReplacementNamed('/home');
                    } : null,
                    borderRadius: 24,
                    backgroundColor:
                        _canSubmit ? primaryPink : const Color(0xFFD0D0D0),
                    foregroundColor:
                        _canSubmit ? Colors.white : const Color(0xFF8A8A8A),
                  );
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'atau',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF242424),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Wrap(
                  children: [
                    Text(
                      'Belum punya akun? ',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF202020),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed('/register'),
                      child: Text(
                        'Daftar',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFEE445E),
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
