import 'package:apartum/core/global_widget/app_button.dart';
import 'package:apartum/core/global_widget/app_inputfield.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apartum/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:apartum/features/profile/presentation/bloc/profile_event.dart';
import 'package:apartum/features/profile/presentation/bloc/profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tanggalPersalinanController = TextEditingController();

  late final Listenable _submitListenable = Listenable.merge([
    _usernameController,
    _nameController,
  ]);

  @override
  void initState() {
    super.initState();
   
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoaded || profileState is ProfileUpdateSuccess) {
      final p = profileState is ProfileLoaded
          ? profileState.profile
          : (profileState as ProfileUpdateSuccess).profile;

      _emailController.text = p.email;
      _nameController.text = p.name;
      _tanggalPersalinanController.text = p.birthDate ?? '';


      final atIndex = p.email.indexOf('@');
      _usernameController.text = atIndex != -1
          ? p.email.substring(0, atIndex)
          : p.name;
    }
  }

  bool get _canSubmit {
    return _nameController.text.trim().isNotEmpty;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Berhasil memperbarui profil')),
          );
          Navigator.of(context).pop();
        } else if (state is ProfileUpdateError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is ProfileUpdateLoading;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            backgroundColor: StaticColor.surface,
            centerTitle: true,
            elevation: 6,
            shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
            surfaceTintColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                AppInputField(
                  label: 'Email',
                  controller: _emailController,
                  enabled: false,
                  readOnly: true,
                  leading: Icon(Icons.email_outlined),
                  statusText:
                      '*Anda tidak dapat mengedit atau mengubah bagian ini.',
                  statusState: AppInputStatusState.error,
                  state: AppInputFieldState.none,
                  enableStatusIcon: false,
                ),
                SizedBox(height: 12),
                AppInputField(
                  label: 'Tanggal Persalinan',
                  controller: _tanggalPersalinanController,
                  enabled: false,
                  readOnly: true,
                  leading: Icon(Icons.calendar_month_outlined),
                  statusText:
                      '*Anda tidak dapat mengedit atau mengubah bagian ini.',
                  statusState: AppInputStatusState.error,
                  state: AppInputFieldState.none,
                  enableStatusIcon: false,
                ),
                SizedBox(height: 12),
                Divider(color: StaticColor.divider),
                SizedBox(height: 12),
                AppInputField(
                  label: 'Username',
                  controller: _nameController,
                  hideHintOnFocus: true,
                  leading: Icon(Icons.face_outlined),
                  trailing: Icon(Icons.edit_outlined),
                  statusText:
                      'Anda dapat mengubah nama Anda, nama tidak boleh sama dengan sebelumnya.',
                  state: AppInputFieldState.normal,
                  enableStatusIcon: false,
                ),
                SizedBox(height: 24),
                AnimatedBuilder(
                  animation: _submitListenable,
                  builder: (context, _) {
                    final canClick = _canSubmit && !isLoading;
                    return AppButton(
                      label: isLoading ? 'Menyimpan...' : 'Simpan Perubahan',
                      onPressed: canClick
                          ? () {
                              context.read<ProfileBloc>().add(
                                UpdateProfileNameEvent(_nameController.text.trim()),
                              );
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
