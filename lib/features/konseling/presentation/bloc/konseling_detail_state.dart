import 'package:apartum/features/konseling/domain/entities/psychologist_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class KonselingDetailState {
  const KonselingDetailState();
}

class KonselingDetailInitial extends KonselingDetailState {
  const KonselingDetailInitial();
}

class KonselingDetailLoading extends KonselingDetailState {
  const KonselingDetailLoading();
}

class KonselingDetailLoaded extends KonselingDetailState {
  final PsychologistEntity psychologist;
  const KonselingDetailLoaded(this.psychologist);
}

class KonselingDetailError extends KonselingDetailState {
  final String message;
  const KonselingDetailError(this.message);
}
