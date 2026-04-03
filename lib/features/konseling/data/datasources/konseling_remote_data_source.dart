import 'package:apartum/core/network/dio_client.dart';
import 'package:apartum/features/konseling/data/models/psychologist_model.dart';
import 'package:dio/dio.dart';

abstract class KonselingRemoteDataSource {
  Future<List<PsychologistModel>> getPsychologists();
  Future<PsychologistModel> getPsychologistDetail(String id);
}

class KonselingRemoteDataSourceImpl implements KonselingRemoteDataSource {
  final DioClient _dioClient;

  KonselingRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<PsychologistModel>> getPsychologists() async {
    final response = await _dioClient.dio.get('/psychologists/');
    if (response.statusCode == 200 && response.data['success'] == true) {
      final rawData = response.data['data'];
      if (rawData == null) return [];
      final dataList = rawData as List;
      return dataList
          .where((item) => item != null)
          .map((item) => PsychologistModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }

  @override
  Future<PsychologistModel> getPsychologistDetail(String id) async {
    final response = await _dioClient.dio.get('/psychologists/$id');
    if (response.statusCode == 200 && response.data['success'] == true) {
      final rawData = response.data['data'];
      if (rawData == null) {
        throw Exception('Psychologist not found');
      }
      return PsychologistModel.fromJson(rawData as Map<String, dynamic>);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }
}
