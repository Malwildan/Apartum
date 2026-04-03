import 'package:apartum/features/konseling/domain/repositories/konseling_repository.dart';
import 'package:apartum/features/konseling/presentation/cubit/konseling_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KonselingDetailCubit extends Cubit<KonselingDetailState> {
  final KonselingRepository _repository;

  KonselingDetailCubit(this._repository) : super(KonselingDetailInitial());

  Future<void> fetchPsychologistDetail(String id) async {
    emit(KonselingDetailLoading());
    try {
      final psychologist = await _repository.getPsychologistDetail(id);
      emit(KonselingDetailLoaded(psychologist));
    } catch (e) {
      emit(KonselingDetailError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
