abstract class KonselingDetailEvent {
  const KonselingDetailEvent();
}

class FetchPsychologistDetailEvent extends KonselingDetailEvent {
  final String id;
  const FetchPsychologistDetailEvent(this.id);
}
