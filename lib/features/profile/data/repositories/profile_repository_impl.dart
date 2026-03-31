import 'package:apartum/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:apartum/features/profile/domain/entities/profile_entity.dart';
import 'package:apartum/features/profile/domain/repositories/profile_repository.dart';
import 'package:dio/dio.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<ProfileEntity> getProfile() async {
    try {
      return await _remoteDataSource.getProfile();
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception('Gagal memuat profil. Terjadi kesalahan pada server.');
    }
  }

  @override
  Future<ProfileEntity> updateProfileName(String name) async {
    try {
      return await _remoteDataSource.updateProfileName(name);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception('Gagal mengupdate profil.');
    }
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
    return 'Terjadi kesalahan pada permintaan ke server.';
  }
}
