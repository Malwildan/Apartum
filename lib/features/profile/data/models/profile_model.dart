import 'package:apartum/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.name,
    required super.email,
    required super.birthDate,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    
    Map<String, dynamic> userData = json;

    if (json.containsKey('data')) {
      final data = json['data'];
      if (data is Map<String, dynamic>) {
        if (data.containsKey('user')) {
          userData = data['user'] as Map<String, dynamic>;
        } else {
          userData = data;
        }
      }
    }

    String? rawBirthDate = userData['birth_date'] as String?;
    String formattedBirthDate = 'Tanggal Tidak Diketahui';

    if (rawBirthDate != null && rawBirthDate.isNotEmpty) {
      try {
        final parsedDate = DateTime.parse(rawBirthDate);
        final y = parsedDate.year.toString().padLeft(4, '0');
        final m = parsedDate.month.toString().padLeft(2, '0');
        final d = parsedDate.day.toString().padLeft(2, '0');
        formattedBirthDate = '$y-$m-$d';
      } catch (_) {
        if (rawBirthDate.contains('T')) {
          formattedBirthDate = rawBirthDate.split('T').first;
        } else {
          formattedBirthDate = rawBirthDate;
        }
      }
    }

    return ProfileModel(
      name: userData['name'] as String? ?? 'Nama Tidak Diketahui',
      email: userData['email'] as String? ?? 'Email Tidak Diketahui',
      birthDate: formattedBirthDate,
    );
  }
}
