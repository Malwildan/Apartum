import 'package:apartum/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  /// Login with email and password.
  /// Returns the authenticated [UserEntity] on success.
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  /// Register a new account.
  /// Returns the created [UserEntity] on success.
  Future<UserEntity> register({
    required String name,
    required String birthDate,
    required String email,
    required String password,
    required String confirmPassword,
  });

  /// Refresh the access token using the stored refresh token.
  Future<void> refreshToken();

  /// Clear all stored credentials and log out.
  Future<void> logout();

  /// Check if user is currently logged in (has stored token).
  bool get isLoggedIn;
}
