import 'package:apartum/features/konseling/domain/repositories/konseling_repository.dart';
import 'package:apartum/features/konseling/presentation/bloc/konseling_detail_event.dart';
import 'package:apartum/features/konseling/presentation/bloc/konseling_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KonselingDetailBloc
    extends Bloc<KonselingDetailEvent, KonselingDetailState> {
  final KonselingRepository _repository;

  KonselingDetailBloc(this._repository) : super(KonselingDetailInitial()) {
    on<FetchPsychologistDetailEvent>(_onFetchDetail);
  }

  Future<void> _onFetchDetail(FetchPsychologistDetailEvent event,
      Emitter<KonselingDetailState> emit) async {
    emit(KonselingDetailLoading());
    try {
      final psychologist = await _repository.getPsychologistDetail(event.id);
      emit(KonselingDetailLoaded(psychologist));
    } catch (e) {
      emit(KonselingDetailError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
