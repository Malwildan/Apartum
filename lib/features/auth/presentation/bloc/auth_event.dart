import 'package:flutter/foundation.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String birthDate;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterEvent({
    required this.name,
    required this.birthDate,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
