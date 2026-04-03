import 'package:apartum/features/konseling/domain/repositories/konseling_repository.dart';
import 'package:apartum/features/konseling/presentation/bloc/konseling_state.dart';
import 'package:apartum/features/konseling/presentation/bloc/konseling_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KonselingBloc extends Bloc<KonselingEvent, KonselingState> {
  final KonselingRepository _repository;

  KonselingBloc(this._repository) : super(KonselingInitial()) {
    on<FetchPsychologistsEvent>(_onFetchPsychologists);
  }

  Future<void> _onFetchPsychologists(
      FetchPsychologistsEvent event, Emitter<KonselingState> emit) async {
    emit(KonselingLoading());
    try {
      final psychologists = await _repository.getPsychologists();
      emit(KonselingLoaded(psychologists));
    } catch (e) {
      emit(KonselingError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
