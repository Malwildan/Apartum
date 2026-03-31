import 'package:apartum/core/global_widget/button.dart';
import 'package:apartum/core/global_widget/inputfield.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:apartum/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _onLoginPressed() {
    FocusScope.of(context).unfocus();
    context.read<AuthCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: StaticColor.destructive,
            ),
          );
        } else if (state is AuthSuccess) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Scaffold(
        backgroundColor: StaticColor.background,
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 87),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: StaticColor.textPrimary,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    'Masuk',
                    style: AppTypography.h1.copyWith(
                      color: StaticColor.primaryPink,
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
                    color: StaticColor.textMuted,
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
                    color: StaticColor.textMuted,
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
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;

                    return AnimatedBuilder(
                      animation: _submitListenable,
                      builder: (context, _) {
                        return AppButton(
                          label: isLoading ? 'Memproses...' : 'Masuk',
                          onPressed: (_canSubmit && !isLoading)
                              ? _onLoginPressed
                              : null,
                          borderRadius: 24,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'atau',
                    style: AppTypography.b2.copyWith(
                      color: StaticColor.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Wrap(
                    children: [
                      Text(
                        'Belum punya akun? ',
                        style: AppTypography.b2.copyWith(
                          color: StaticColor.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamed('/register'),
                        child: Text(
                          'Daftar',
                          style: AppTypography.b2.copyWith(
                            fontWeight: FontWeight.w700,
                            color: StaticColor.primaryPink,
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
      ),
    );
  }
}
