import 'package:dio/dio.dart';

import 'package:apartum/features/riwayat_catatan/data/datasources/symptom_remote_data_source.dart';
import 'package:apartum/features/riwayat_catatan/data/models/symptom_request_model.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_entity.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/symptom_request_entity.dart';
import 'package:apartum/features/riwayat_catatan/domain/repositories/symptom_repository.dart';

class SymptomRepositoryImpl implements SymptomRepository {
  final SymptomRemoteDataSource _remoteDataSource;

  SymptomRepositoryImpl(this._remoteDataSource);

  @override
  Future<SymptomEntity> saveSymptom(SymptomRequestEntity request) async {
    try {
      return await _remoteDataSource.saveSymptom(
        SymptomRequestModel(
          date: request.date,
          bleedings: request.bleedings,
          physical: request.physical,
          moods: request.moods,
        ),
      );
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (_) {
      throw Exception('Terjadi kesalahan saat menyimpan gejala.');
    }
  }

  @override
  Future<SymptomEntity> getSymptomDetail(String date) async {
    try {
      return await _remoteDataSource.getSymptomDetail(date);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw const SymptomNotFoundException('Belum ada pencatatan pada tanggal ini.');
      }
      throw Exception(_extractErrorMessage(e));
    } catch (_) {
      throw Exception('Terjadi kesalahan saat memuat riwayat gejala.');
    }
  }

  @override
  Future<List<SymptomEntity>> getSymptomHistory() async {
    try {
      return await _remoteDataSource.getSymptomHistory();
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (_) {
      throw Exception('Terjadi kesalahan saat memuat riwayat gejala.');
    }
  }

  String _extractErrorMessage(DioException e) {
    if (e.response?.statusCode == 401) {
      return 'Sesi telah berakhir. Silakan masuk kembali.';
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return 'Koneksi terputus. Silakan coba lagi.';
    }

    final responseData = e.response?.data;
    if (responseData is Map<String, dynamic>) {
      final message = responseData['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    return 'Terjadi kesalahan. Silakan coba lagi.';
  }
}
