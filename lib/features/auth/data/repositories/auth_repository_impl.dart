import 'package:apartum/core/network/token_storage.dart';
import 'package:apartum/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:apartum/features/auth/domain/entities/user_entity.dart';
import 'package:apartum/features/auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._remoteDataSource, this._tokenStorage);

  @override
  bool get isLoggedIn {
    // We can't synchronously check FlutterSecureStorage, but usually this getter 
    // is replaced by an async initialization check at app start. 
    // For now we assume if we need to check synchronously, we shouldn't.
    throw UnimplementedError('Use async token storage checks instead.');
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      return await _handleAuthResponse(response);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Email atau kata sandi salah.');
      }
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception('Terjadi kesalahan yang tidak terduga.');
    }
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String birthDate,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _remoteDataSource.register(
        name: name,
        birthDate: birthDate,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      return await _handleAuthResponse(response);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception(
          e.response?.data?['message'] ?? 'Data yang dimasukkan tidak valid.',
        );
      }
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception('Terjadi kesalahan yang tidak terduga.');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken != null) {
        await _remoteDataSource.logout(refreshToken);
      }
    } catch (_) {
      // Ignore API errors during logout (e.g., timeout or invalid token)
      // to ensure the local user is still effectively logged out regardless.
    } finally {
      await _tokenStorage.clearAll();
    }
  }

  @override
  Future<void> refreshToken() async {
    // Refresh token logic is handled automatically by DioClient interceptor.
    // If we need to trigger it manually, we would hit the RemoteDataSource.
  }

  Future<UserEntity> _handleAuthResponse(response) async {
    if (response.success && response.user != null) {
      final user = response.user!;
      
      if (response.accessToken != null && response.refreshToken != null) {
        await _tokenStorage.saveTokens(
          accessToken: response.accessToken!,
          refreshToken: response.refreshToken!,
        );
      }
      
      await _tokenStorage.saveUserInfo(
        name: user.name,
        email: user.email,
        birthDate: user.birthDate,
      );
      
      return user;
    }
    throw Exception('Autentikasi gagal.');
  }

  String _extractErrorMessage(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Koneksi terputus. Silakan coba lagi.';
    }
    if (e.response != null && e.response?.data != null) {
      if (e.response?.data is Map) {
        return e.response?.data['message'] ?? 'Terjadi kesalahan pada server.';
      }
    }
    return 'Terjadi kesalahan pada server.';
  }
}
