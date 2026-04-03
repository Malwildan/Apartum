import 'package:apartum/core/network/dio_client.dart';
import 'package:apartum/features/riwayat_catatan/data/models/symptom_model.dart';
import 'package:apartum/features/riwayat_catatan/data/models/symptom_request_model.dart';
import 'package:dio/dio.dart';

abstract class SymptomRemoteDataSource {
  Future<SymptomModel> saveSymptom(SymptomRequestModel request);
  Future<SymptomModel> getSymptomDetail(String date);
  Future<List<SymptomModel>> getSymptomHistory();
}

class SymptomRemoteDataSourceImpl implements SymptomRemoteDataSource {
  final DioClient _dioClient;

  SymptomRemoteDataSourceImpl(this._dioClient);

  @override
  Future<SymptomModel> saveSymptom(SymptomRequestModel request) async {
    final response = await _dioClient.dio.post('/symptom/', data: request.toJson());

    if (response.statusCode == 200 && response.data['success'] == true) {
      return SymptomModel.fromJson(response.data['data'] as Map<String, dynamic>);
    }

    throw DioException(requestOptions: response.requestOptions, response: response);
  }

  @override
  Future<SymptomModel> getSymptomDetail(String date) async {
    final response = await _dioClient.dio.get('/symptom/$date');

    if (response.statusCode == 200 && response.data['success'] == true) {
      return SymptomModel.fromJson(response.data['data'] as Map<String, dynamic>);
    }

    throw DioException(requestOptions: response.requestOptions, response: response);
  }

  @override
  Future<List<SymptomModel>> getSymptomHistory() async {
    final response = await _dioClient.dio.get('/symptom/history');

    if (response.statusCode == 200 && response.data['success'] == true) {
      final data = response.data['data'] as List<dynamic>? ?? [];
      return data
          .map((e) => SymptomModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw DioException(requestOptions: response.requestOptions, response: response);
  }
}
