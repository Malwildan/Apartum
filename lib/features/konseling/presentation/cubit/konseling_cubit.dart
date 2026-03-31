import 'package:apartum/features/konseling/domain/repositories/konseling_repository.dart';
import 'package:apartum/features/konseling/presentation/cubit/konseling_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KonselingCubit extends Cubit<KonselingState> {
  final KonselingRepository _repository;

  KonselingCubit(this._repository) : super(KonselingInitial());

  Future<void> fetchPsychologists() async {
    emit(KonselingLoading());
    try {
      final psychologists = await _repository.getPsychologists();
      emit(KonselingLoaded(psychologists));
    } catch (e) {
      emit(KonselingError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
