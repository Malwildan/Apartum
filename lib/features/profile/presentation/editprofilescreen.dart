import 'package:apartum/core/global_widget/button.dart';
import 'package:apartum/core/global_widget/inputfield.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  late final Listenable _submitListenable = Listenable.merge([
    _usernameController,
    _nameController,
  ]);

  bool get _canSubmit {
    return _usernameController.text.trim().isNotEmpty ||
        _nameController.text.trim().isNotEmpty;
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
    const Color primaryPink = Color(0xFFFF4B6E);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
              hintText: 'wildatussakinah9@gmail.com',
              leading: Icon(Icons.email_outlined),
              statusText:
                  '*Anda tidak dapat mengedit atau mengubah bagian ini.',
              statusState: AppInputStatusState.error,
              state: AppInputFieldState.none,
              enableStatusIcon: false,
            ),
            SizedBox(height: 12),
            Divider(color: Colors.grey),
            SizedBox(height: 12),
            AppInputField(
              label: 'Username',
              controller: _usernameController,
              hintText: 'wildatussa9',
              hideHintOnFocus: true,
              leading: Icon(Icons.person_outline),
              trailing: Icon(Icons.edit_outlined),
              statusText:
                  'Anda dapat mengubah username Anda, username tidak boleh sama dengan sebelumnya.',
              statusState: AppInputStatusState.normal,
              state: AppInputFieldState.normal,
              enableStatusIcon: false,
            ),
            SizedBox(height: 12),
            AppInputField(
              label: 'Nama',
              controller: _nameController,
              hintText: 'Wildatus Sakinah',
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
                return AppButton(
                  label: 'Simpan Perubahan',
                  onPressed: _canSubmit
                      ? () {
                          Navigator.of(context).pushReplacementNamed('/home');
                        }
                      : null,
                  borderRadius: 24,
                  backgroundColor: _canSubmit
                      ? primaryPink
                      : const Color(0xFFD0D0D0),
                  foregroundColor: _canSubmit
                      ? Colors.white
                      : const Color(0xFF8A8A8A),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
