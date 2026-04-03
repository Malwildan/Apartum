class Bagian1AnswerData {
  final String? pembalut;
  final String? warnaDarah;
  final String? gumpalan;
  final String? bau;

  const Bagian1AnswerData({
    this.pembalut,
    this.warnaDarah,
    this.gumpalan,
    this.bau,
  });

  Bagian1AnswerData copyWith({
    String? pembalut,
    String? warnaDarah,
    String? gumpalan,
    String? bau,
  }) {
    return Bagian1AnswerData(
      pembalut: pembalut ?? this.pembalut,
      warnaDarah: warnaDarah ?? this.warnaDarah,
      gumpalan: gumpalan ?? this.gumpalan,
      bau: bau ?? this.bau,
    );
  }
}

class Bagian2AnswerData {
  final String? suhuTubuh;
  final int? pusingLevel;
  final int? lemasLevel;
  final int? nyeriBetisLevel;
  final int? nyeriPerutLevel;
  final List<String> kondisiPerban;
  final List<String> masalahPayudara;
  final List<String> masalahBAK;
  final List<String> warnaUrine;
  final List<String> tubuhBengkak;
  final List<String> gejalaLain;

  const Bagian2AnswerData({
    this.suhuTubuh,
    this.pusingLevel,
    this.lemasLevel,
    this.nyeriBetisLevel,
    this.nyeriPerutLevel,
    this.kondisiPerban = const [],
    this.masalahPayudara = const [],
    this.masalahBAK = const [],
    this.warnaUrine = const [],
    this.tubuhBengkak = const [],
    this.gejalaLain = const [],
  });

  Bagian2AnswerData copyWith({
    String? suhuTubuh,
    int? pusingLevel,
    int? lemasLevel,
    int? nyeriBetisLevel,
    int? nyeriPerutLevel,
    List<String>? kondisiPerban,
    List<String>? masalahPayudara,
    List<String>? masalahBAK,
    List<String>? warnaUrine,
    List<String>? tubuhBengkak,
    List<String>? gejalaLain,
  }) {
    return Bagian2AnswerData(
      suhuTubuh: suhuTubuh ?? this.suhuTubuh,
      pusingLevel: pusingLevel ?? this.pusingLevel,
      lemasLevel: lemasLevel ?? this.lemasLevel,
      nyeriBetisLevel: nyeriBetisLevel ?? this.nyeriBetisLevel,
      nyeriPerutLevel: nyeriPerutLevel ?? this.nyeriPerutLevel,
      kondisiPerban: kondisiPerban ?? this.kondisiPerban,
      masalahPayudara: masalahPayudara ?? this.masalahPayudara,
      masalahBAK: masalahBAK ?? this.masalahBAK,
      warnaUrine: warnaUrine ?? this.warnaUrine,
      tubuhBengkak: tubuhBengkak ?? this.tubuhBengkak,
      gejalaLain: gejalaLain ?? this.gejalaLain,
    );
  }
}

class Bagian3AnswerData {
  final List<String> selectedEmotions;

  const Bagian3AnswerData({this.selectedEmotions = const []});

  Bagian3AnswerData copyWith({
    List<String>? selectedEmotions,
  }) {
    return Bagian3AnswerData(
      selectedEmotions: selectedEmotions ?? this.selectedEmotions,
    );
  }
}
