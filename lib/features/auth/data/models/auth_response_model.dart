import 'package:apartum/features/auth/data/models/user_model.dart';

class AuthResponseModel {
  final bool success;
  final UserModel? user;
  final String? accessToken;
  final String? refreshToken;

  const AuthResponseModel({
    required this.success,
    this.user,
    this.accessToken,
    this.refreshToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != true || json['data'] == null) {
      return AuthResponseModel(success: json['success'] ?? false);
    }

    final data = json['data'] as Map<String, dynamic>;
    return AuthResponseModel(
      success: true,
      user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
      accessToken: data['access_token'],
      refreshToken: data['refresh_token'],
    );
  }
}
