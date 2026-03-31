import 'package:dio/dio.dart';

void main() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://be-internship.bccdev.id/salma/api/v1',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    )
  );
  
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  try {
    final response = await dio.post(
      '/auth/register',
      data: {
        'name': 'Salma Uji Coba',
        'birth_date': '2025-01-31',
        'email': 'salma.uji123@gmail.com',
        'password': 'password123',
        'confirm_password': 'password123',
      },
    );
    print('SUCCESS: ${response.data}');
  } on DioException catch (e) {
    print('ERROR response data: ${e.response?.data}');
  }
}
