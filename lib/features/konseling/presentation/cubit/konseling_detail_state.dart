import 'package:apartum/features/konseling/domain/entities/psychologist_entity.dart';

abstract class KonselingDetailState {
  const KonselingDetailState();
}

class KonselingDetailInitial extends KonselingDetailState {}

class KonselingDetailLoading extends KonselingDetailState {}

class KonselingDetailLoaded extends KonselingDetailState {
  final PsychologistEntity psychologist;

  const KonselingDetailLoaded(this.psychologist);
}

class KonselingDetailError extends KonselingDetailState {
  final String message;

  const KonselingDetailError(this.message);
}
