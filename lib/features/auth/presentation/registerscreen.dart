import 'package:apartum/core/global_widget/button.dart';
import 'package:apartum/core/global_widget/inputfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
	final TextEditingController _confirmPasswordController = TextEditingController();
	late final Listenable _submitListenable = Listenable.merge([
		_nameController,
		_birthDateController,
		_emailController,
		_passwordController,
		_confirmPasswordController,
	]);

	bool _obscurePassword = true;
	bool _obscureConfirmPassword = true;

	bool get _canSubmit {
		final bool allFilled = _nameController.text.trim().isNotEmpty &&
				_birthDateController.text.trim().isNotEmpty &&
				_emailController.text.trim().isNotEmpty &&
				_passwordController.text.trim().isNotEmpty &&
				_confirmPasswordController.text.trim().isNotEmpty;

		return allFilled && _passwordController.text == _confirmPasswordController.text;
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

		final String formatted =
				'${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}';

		_birthDateController.text = formatted;
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
						padding: EdgeInsets.fromLTRB(20,16,20,0),
						children: [
							Row(
                mainAxisAlignment: MainAxisAlignment.start,
							  children: [
							    IconButton(
							    	onPressed: () => Navigator.of(context).maybePop(),
							    	icon: const Icon(Icons.arrow_back_ios_new_rounded),
							    	color: const Color(0xFF222222),
							    	padding: EdgeInsets.zero,
							    	constraints: const BoxConstraints(),
							    ),
							  ],
							),
							const SizedBox(height: 30),
							Center(
								child: Text(
									'Daftar Akun',
									style: GoogleFonts.plusJakartaSans(
										fontSize: 24,
										fontWeight: FontWeight.w700,
										color: primaryPink,
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
									color: Color(0xFF6A6A6A),
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
									color: Color(0xFF6A6A6A),
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
									color: Color(0xFF6A6A6A),
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
									color: Color(0xFF6A6A6A),
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
									color: Color(0xFF6A6A6A),
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
											'Sudah punya akun? ',
											style: GoogleFonts.plusJakartaSans(
												fontSize: 14,
												fontWeight: FontWeight.w500,
												color: const Color(0xFF202020),
											),
										),
										GestureDetector(
											onTap: () => Navigator.of(context).pushNamed('/login'),
											child: Text(
												'Masuk',
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
							const SizedBox(height: 87),
						],
					),
				),
			),
		);
	}
}
