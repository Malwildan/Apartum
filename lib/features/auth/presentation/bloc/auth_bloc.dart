import 'package:apartum/core/network/token_storage.dart';
import 'package:apartum/features/auth/domain/entities/user_entity.dart';
import 'package:apartum/features/auth/domain/repositories/auth_repository.dart';
import 'package:apartum/features/auth/presentation/bloc/auth_event.dart';
import 'package:apartum/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  final TokenStorage _tokenStorage;

  AuthBloc(this._repository, this._tokenStorage) : super(const AuthInitial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final isLoggedIn = await _tokenStorage.isLoggedIn();
    if (isLoggedIn) {
      final name = await _tokenStorage.getUserName() ?? '';
      final email = await _tokenStorage.getUserEmail() ?? '';
      final birthDate = await _tokenStorage.getUserBirthDate() ?? '';

      emit(AuthSuccess(
        UserEntity(name: name, email: email, birthDate: birthDate),
      ));
    } else {
      emit(const AuthNotLoggedIn());
    }
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _repository.login(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onRegister(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _repository.register(
        name: event.name,
        birthDate: event.birthDate,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await _repository.logout();
    emit(const AuthNotLoggedIn());
  }
}
