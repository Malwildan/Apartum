import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _keyAccessToken = 'access_token';
  static const _keyRefreshToken = 'refresh_token';
  static const _keyUserName = 'user_name';
  static const _keyUserEmail = 'user_email';
  static const _keyUserBirthDate = 'user_birth_date';

  final FlutterSecureStorage _storage;

  TokenStorage(this._storage);

  // ── Tokens ──

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _keyAccessToken, value: accessToken);
    await _storage.write(key: _keyRefreshToken, value: refreshToken);
  }

  Future<String?> getAccessToken() => _storage.read(key: _keyAccessToken);
  Future<String?> getRefreshToken() => _storage.read(key: _keyRefreshToken);

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null;
  }

  // ── User info ──

  Future<void> saveUserInfo({
    required String name,
    required String email,
    required String birthDate,
  }) async {
    await _storage.write(key: _keyUserName, value: name);
    await _storage.write(key: _keyUserEmail, value: email);
    await _storage.write(key: _keyUserBirthDate, value: birthDate);
  }

  Future<String?> getUserName() => _storage.read(key: _keyUserName);
  Future<String?> getUserEmail() => _storage.read(key: _keyUserEmail);
  Future<String?> getUserBirthDate() => _storage.read(key: _keyUserBirthDate);

  // ── Clear ──

  Future<void> clearAll() async {
    await _storage.delete(key: _keyAccessToken);
    await _storage.delete(key: _keyRefreshToken);
    await _storage.delete(key: _keyUserName);
    await _storage.delete(key: _keyUserEmail);
    await _storage.delete(key: _keyUserBirthDate);
  }
}

