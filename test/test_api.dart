import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  // 1. Test JSON
  try {
    final response = await dio.post(
      'https://be-internship.bccdev.id/salma/api/v1/auth/register',
      data: {
        'name': 'Test User JSON',
        'birth_date': '1995-12-15',
        'email': 'testing1235451@gmail.com',
        'password': 'password123',
        'confirm_password': 'password123',
      },
      options: Options(headers: {'Accept': 'application/json'}),
    );
    print('JSON Success: ${response.data}');
  } on DioException catch (e) {
    print('JSON Error: ${e.response?.data}');
  }

  // 2. Test FormData
  try {
    final response2 = await dio.post(
      'https://be-internship.bccdev.id/salma/api/v1/auth/register',
      data: FormData.fromMap({
        'name': 'Test User FORM',
        'birth_date': '1995-12-15',
        'email': 'testing1235452@gmail.com',
        'password': 'password123',
        'confirm_password': 'password123',
      }),
      options: Options(headers: {'Accept': 'application/json'}),
    );
    print('FORM Success: ${response2.data}');
  } on DioException catch (e) {
    print('FORM Error: ${e.response?.data}');
  }
}
