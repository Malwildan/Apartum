import 'package:apartum/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  /// Fetch the authenticated user's profile.
  Future<ProfileEntity> getProfile();

  /// Update the authenticated user's profile name.
  Future<ProfileEntity> updateProfileName(String name);
}
