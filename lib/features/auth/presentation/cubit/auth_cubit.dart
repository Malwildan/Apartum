import 'package:apartum/core/network/token_storage.dart';
import 'package:apartum/features/auth/domain/entities/user_entity.dart';
import 'package:apartum/features/auth/domain/repositories/auth_repository.dart';
import 'package:apartum/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  final TokenStorage _tokenStorage;

  AuthCubit(this._repository, this._tokenStorage) : super(AuthInitial());

  /// Check if the user is already logged in internally on startup.
  Future<void> checkAuthStatus() async {
    final isLoggedIn = await _tokenStorage.isLoggedIn();
    if (isLoggedIn) {
      final name = await _tokenStorage.getUserName() ?? '';
      final email = await _tokenStorage.getUserEmail() ?? '';
      final birthDate = await _tokenStorage.getUserBirthDate() ?? '';
      
      emit(AuthSuccess(
        UserEntity(name: name, email: email, birthDate: birthDate),
      ));
    } else {
      emit(AuthNotLoggedIn());
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _repository.login(email: email, password: password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> register({
    required String name,
    required String birthDate,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _repository.register(
        name: name,
        birthDate: birthDate,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await _repository.logout();
    emit(AuthNotLoggedIn());
  }
}
