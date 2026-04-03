import 'package:apartum/features/konseling/domain/entities/psychologist_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class KonselingState {
  const KonselingState();
}

class KonselingInitial extends KonselingState {
  const KonselingInitial();
}

class KonselingLoading extends KonselingState {
  const KonselingLoading();
}

class KonselingLoaded extends KonselingState {
  final List<PsychologistEntity> psychologists;
  const KonselingLoaded(this.psychologists);
}

class KonselingError extends KonselingState {
  final String message;
  const KonselingError(this.message);
}
