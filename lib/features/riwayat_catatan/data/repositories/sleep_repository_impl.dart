import 'package:apartum/features/riwayat_catatan/data/datasources/sleep_remote_data_source.dart';
import 'package:apartum/features/riwayat_catatan/domain/entities/sleep_daily_entity.dart';
import 'package:apartum/features/riwayat_catatan/domain/repositories/sleep_repository.dart';
import 'package:dio/dio.dart';

class SleepRepositoryImpl implements SleepRepository {
  final SleepRemoteDataSource _remoteDataSource;

  SleepRepositoryImpl(this._remoteDataSource);

  @override
  Future<SleepDailyEntity> getSleepDaily(String date) async {
    try {
      return await _remoteDataSource.getSleepDaily(date);
    } on DioException catch (e) {
      throw Exception(_extractDailyErrorMessage(e));
    } catch (_) {
      throw Exception('Terjadi kesalahan saat memuat riwayat tidur bayi.');
    }
  }

  @override
  Future<void> addManualSleep(String start, String end) async {
    try {
      await _remoteDataSource.addManualSleep(start, end);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (_) {
      throw Exception('Terjadi kesalahan saat menyimpan catatan tidur bayi.');
    }
  }

  @override
  Future<void> startSleep() async {
    try {
      await _remoteDataSource.startSleep();
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (_) {
      throw Exception('Terjadi kesalahan saat memulai catatan tidur bayi.');
    }
  }

  @override
  Future<void> endSleep() async {
    try {
      await _remoteDataSource.endSleep();
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (_) {
      throw Exception('Terjadi kesalahan saat mengakhiri catatan tidur bayi.');
    }
  }

  String _extractDailyErrorMessage(DioException e) {
    if (e.response?.statusCode == 404) {
      return 'Belum ada pencatatan tidur bayi pada tanggal ini.';
    }

    return _extractErrorMessage(e);
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
