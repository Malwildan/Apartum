import 'package:apartum/core/network/dio_client.dart';
import 'package:apartum/features/profile/data/models/profile_model.dart';


abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfileName(String name);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient _dioClient;

  ProfileRemoteDataSourceImpl(this._dioClient);

  @override
  Future<ProfileModel> getProfile() async {
    final response = await _dioClient.dio.get('/user/profile');
    return ProfileModel.fromJson(response.data);
  }

  @override
  Future<ProfileModel> updateProfileName(String name) async {
    final response = await _dioClient.dio.patch(
      '/user/profile',
      data: {
        'name': name,
      },
    );
    return ProfileModel.fromJson(response.data);
  }
}
