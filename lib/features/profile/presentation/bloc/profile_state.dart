import 'package:apartum/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  const ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}

class ProfileUpdateLoading extends ProfileState {
  const ProfileUpdateLoading();
}

class ProfileUpdateSuccess extends ProfileState {
  final ProfileEntity profile;

  const ProfileUpdateSuccess(this.profile);
}

class ProfileUpdateError extends ProfileState {
  final String message;

  const ProfileUpdateError(this.message);
}
