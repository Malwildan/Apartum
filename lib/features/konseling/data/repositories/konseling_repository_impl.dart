import 'package:apartum/features/konseling/data/datasources/konseling_remote_data_source.dart';
import 'package:apartum/features/konseling/domain/entities/psychologist_entity.dart';
import 'package:apartum/features/konseling/domain/repositories/konseling_repository.dart';
import 'package:dio/dio.dart';

class KonselingRepositoryImpl implements KonselingRepository {
  final KonselingRemoteDataSource _remoteDataSource;

  KonselingRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<PsychologistEntity>> getPsychologists() async {
    try {
      return await _remoteDataSource.getPsychologists();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Sesi telah berakhir. Silakan masuk kembali.');
      }
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception('Terjadi kesalahan pada server saat memuat data psikolog.');
    }
  }

  @override
  Future<PsychologistEntity> getPsychologistDetail(String id) async {
    try {
      return await _remoteDataSource.getPsychologistDetail(id);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Sesi telah berakhir. Silakan masuk kembali.');
      }
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception('Terjadi kesalahan pada server saat memuat detail psikolog.');
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
    return 'Terjadi kesalahan. Silakan coba lagi.';
  }
}
