import 'package:apartum/features/konseling/domain/entities/psychologist_entity.dart';

abstract class KonselingState {
  const KonselingState();
}

class KonselingInitial extends KonselingState {}

class KonselingLoading extends KonselingState {}

class KonselingLoaded extends KonselingState {
  final List<PsychologistEntity> psychologists;

  const KonselingLoaded(this.psychologists);
}

class KonselingError extends KonselingState {
  final String message;

  const KonselingError(this.message);
}
