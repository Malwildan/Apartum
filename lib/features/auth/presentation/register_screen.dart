import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/global_widget/app_inputfield.dart';
import 'package:apartum/core/global_widget/status_card_widget.dart';
import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:apartum/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:apartum/features/auth/presentation/cubit/auth_state.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_bloc.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late final Listenable _submitListenable = Listenable.merge([
    _nameController,
    _birthDateController,
    _emailController,
    _passwordController,
    _confirmPasswordController,
  ]);

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  DateTime? _selectedDate;

  bool get _canSubmit {
    final bool allFilled =
        _nameController.text.trim().isNotEmpty &&
        _selectedDate != null &&
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty &&
        _confirmPasswordController.text.trim().isNotEmpty;

    return allFilled &&
        _passwordController.text == _confirmPasswordController.text;
  }

  Future<void> _pickBirthDate() async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 25),
      firstDate: DateTime(1950),
      lastDate: now,
    );

    if (pickedDate == null) {
      return;
    }

    _selectedDate = pickedDate;
    final String formatted =
        '${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}';

    _birthDateController.text = formatted;
  }

  void _onRegisterPressed() {
    FocusScope.of(context).unfocus();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider.value(
        value: context.read<AuthCubit>(),
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                  child: StatusCardWidget(status: CardStatus.loading),
                );
              } else if (state is AuthSuccess) {
                return Center(
                  child: StatusCardWidget(
                    status: CardStatus.success,
                    onSuccess: () {
                      context.read<SymptomBloc>().add(const ResetSymptomCacheEvent());
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                  ),
                );
              } else if (state is AuthFailure) {
                return Center(
                  child: StatusCardWidget(
                    status: CardStatus.error,
                    onError: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    // API expects strictly YYYY-MM-DD
    final yyyymmdd =
        '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}';

    context.read<AuthCubit>().register(
      name: _nameController.text.trim(),
      birthDate: yyyymmdd,
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      confirmPassword: _confirmPasswordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColor.background,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
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
                  'Daftar Akun',
                  style: AppTypography.h1.copyWith(
                    color: StaticColor.primaryPink,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              AppInputField(
                label: 'Nama Pengguna',
                hintText: 'Masukkan Nama Ibu',
                controller: _nameController,
                hideHintOnFocus: true,
                leading: const Icon(
                  Icons.person_outline_rounded,
                  color: StaticColor.textMuted,
                ),
                trailing: const SizedBox.shrink(),
                state: AppInputFieldState.normal,
                borderRadius: 18,
              ),
              const SizedBox(height: 26),
              AppInputField(
                label: 'Tanggal Persalinan',
                hintText: 'Masukkan Tanggal Persalinan Ibu',
                controller: _birthDateController,
                readOnly: true,
                onTap: _pickBirthDate,
                leading: const Icon(
                  Icons.calendar_month_outlined,
                  color: StaticColor.textMuted,
                ),
                trailing: const SizedBox.shrink(),
                statusText: 'Format: DD-MM-YYY. Contoh: 31-01-2025',
                state: AppInputFieldState.normal,
                borderRadius: 18,
              ),
              const SizedBox(height: 26),
              AppInputField(
                label: 'Email',
                hintText: 'Masukkan Email Anda',
                controller: _emailController,
                hideHintOnFocus: true,
                keyboardType: TextInputType.emailAddress,
                leading: const Icon(
                  Icons.email_outlined,
                  color: StaticColor.textMuted,
                ),
                trailing: const SizedBox.shrink(),
                statusText: 'Gunakan email berakhiran @gmail.com',
                state: AppInputFieldState.normal,
                borderRadius: 18,
              ),
              const SizedBox(height: 26),
              AppInputField(
                label: 'Kata Sandi',
                hintText: 'Masukkan Kata Sandi',
                controller: _passwordController,
                hideHintOnFocus: true,
                obscureText: _obscurePassword,
                leading: const Icon(
                  Icons.lock_outline_rounded,
                  color: StaticColor.textMuted,
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  splashRadius: 18,
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                ),
                statusText:
                    'Buat kata sandi minimal 8 karakter dengan kombinasi huruf dan angka',
                state: AppInputFieldState.normal,
                borderRadius: 18,
              ),
              const SizedBox(height: 26),
              AppInputField(
                label: 'Konfirmasi Kata Sandi',
                hintText: 'Masukkan Ulang Kata Sandi',
                controller: _confirmPasswordController,
                hideHintOnFocus: true,
                obscureText: _obscureConfirmPassword,
                leading: const Icon(
                  Icons.lock_outline_rounded,
                  color: StaticColor.textMuted,
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  splashRadius: 18,
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                ),
                statusText:
                    'Masukkan kata sandi yang identik dengan yang dibuat sebelumnya',
                state: AppInputFieldState.normal,
                borderRadius: 18,
              ),
              const SizedBox(height: 30),
              AnimatedBuilder(
                animation: _submitListenable,
                builder: (context, _) {
                  return AppButton(
                    label: 'Daftar',
                    onPressed: _canSubmit ? _onRegisterPressed : null,
                    borderRadius: 24,
                    backgroundColor: _canSubmit
                        ? StaticColor.primaryPink
                        : StaticColor.disabled,
                    foregroundColor: _canSubmit
                        ? Colors.white
                        : StaticColor.disabledText,
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
                      'Sudah punya akun? ',
                      style: AppTypography.b2.copyWith(
                        color: StaticColor.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed('/login'),
                      child: Text(
                        'Masuk',
                        style: AppTypography.b2.copyWith(
                          fontWeight: FontWeight.w700,
                          color: StaticColor.primaryPink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 87),
            ],
          ),
        ),
      ),
    );
  }
}
