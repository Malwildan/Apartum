import 'package:apartum/core/network/dio_client.dart';
import 'package:apartum/features/riwayat_catatan/data/models/sleep_daily_model.dart';
import 'package:dio/dio.dart';

abstract class SleepRemoteDataSource {
  Future<SleepDailyModel> getSleepDaily(String date);
  Future<void> addManualSleep(String start, String end);
  Future<void> startSleep();
  Future<void> endSleep();
}

class SleepRemoteDataSourceImpl implements SleepRemoteDataSource {
  final DioClient _dioClient;

  SleepRemoteDataSourceImpl(this._dioClient);

  @override
  Future<SleepDailyModel> getSleepDaily(String date) async {
    final response = await _dioClient.dio.get(
      '/sleep/daily',
      queryParameters: {'date': date},
    );

    if (response.statusCode == 200 && response.data['success'] == true) {
      return SleepDailyModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
    );
  }

  @override
  Future<void> addManualSleep(String start, String end) async {
    final response = await _dioClient.dio.post(
      '/sleep/manual',
      data: {'start': start, 'end': end},
    );

    if (response.statusCode == 200 && response.data['success'] == true) {
      return;
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
    );
  }

  @override
  Future<void> startSleep() async {
    final response = await _dioClient.dio.post('/sleep/start');

    if (response.statusCode == 200 && response.data['success'] == true) {
      return;
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
    );
  }

  @override
  Future<void> endSleep() async {
    final response = await _dioClient.dio.post('/sleep/end');

    if (response.statusCode == 200 && response.data['success'] == true) {
      return;
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
    );
  }
}
