import 'package:apartum/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {

  Future<ProfileEntity> getProfile();

  Future<ProfileEntity> updateProfileName(String name);
}
