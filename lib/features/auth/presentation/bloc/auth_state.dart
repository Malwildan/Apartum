import 'package:apartum/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final UserEntity user;

  const AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);
}

class AuthNotLoggedIn extends AuthState {
  const AuthNotLoggedIn();
}
