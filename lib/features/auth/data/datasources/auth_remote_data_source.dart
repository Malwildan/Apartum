import 'package:apartum/core/network/dio_client.dart';
import 'package:apartum/features/auth/data/models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  Future<AuthResponseModel> register({
    required String name,
    required String birthDate,
    required String email,
    required String password,
    required String confirmPassword,
  });
  Future<void> logout(String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _dioClient.dio.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> register({
    required String name,
    required String birthDate,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await _dioClient.dio.post(
      '/auth/register',
      data: {
        'name': name,
        'birth_date': birthDate,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      },
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<void> logout(String refreshToken) async {
    await _dioClient.dio.get(
      '/auth/logout',
      data: {
        'refresh_token': refreshToken,
      },
    );
  }
}
