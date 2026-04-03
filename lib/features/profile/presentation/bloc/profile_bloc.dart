import 'package:apartum/features/profile/domain/repositories/profile_repository.dart';
import 'package:apartum/features/profile/presentation/bloc/profile_event.dart';
import 'package:apartum/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(const ProfileInitial()) {
    on<FetchProfileEvent>(_onFetchProfile);
    on<UpdateProfileNameEvent>(_onUpdateProfileName);
  }

  Future<void> _onFetchProfile(
    FetchProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      final profile = await _repository.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onUpdateProfileName(
    UpdateProfileNameEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;

    emit(const ProfileUpdateLoading());

    try {
      final updatedProfile = await _repository.updateProfileName(event.name);
      emit(ProfileUpdateSuccess(updatedProfile));
      emit(ProfileLoaded(updatedProfile));
    } catch (e) {
      emit(ProfileUpdateError(e.toString().replaceAll('Exception: ', '')));
      if (currentState is ProfileLoaded) {
        emit(ProfileLoaded(currentState.profile));
      } else {
        emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
      }
    }
  }
}
