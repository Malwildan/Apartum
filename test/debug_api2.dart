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

  try {
    final response = await dio.post(
      '/auth/register',
      data: {
        'name': 'Salma Uji Coba 2',
        'birth_date': '31-01-2025',
        'email': 'salmax.uji123x@gmail.com',
        'password': 'password123',
        'confirm_password': 'password123',
      },
    );
    print('SUCCESS: ${response.data}');
  } on DioException catch (e) {
    var errorData = e.response?.data;
    print('ERROR response data: $errorData');
  }
}
