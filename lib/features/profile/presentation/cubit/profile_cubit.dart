import 'package:apartum/features/profile/domain/repositories/profile_repository.dart';
import 'package:apartum/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await _repository.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> updateProfileName(String name) async {
    // Keep a reference to the old profile if we are currently loaded,
    // so we can fallback if the update fails without causing UI to vanish.
    final currentState = state;
    
    emit(ProfileUpdateLoading());
    
    try {
      final updatedProfile = await _repository.updateProfileName(name);
      // Emit success so listeners can pop or show snackbar
      emit(ProfileUpdateSuccess(updatedProfile));
      // Re-emit loaded so builders display new data
      emit(ProfileLoaded(updatedProfile)); 
    } catch (e) {
      emit(ProfileUpdateError(e.toString().replaceAll('Exception: ', '')));
      // Restore previous state if it was loaded
      if (currentState is ProfileLoaded) {
        emit(ProfileLoaded(currentState.profile));
      } else {
        emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
      }
    }
  }
}
