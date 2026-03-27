class DoctorData {
  const DoctorData({
    required this.imagePath,
    required this.doctorName,
    required this.specializationAndExperience,
    required this.priceText,
  });

  final String imagePath;
  final String doctorName;
  final String specializationAndExperience;
  final String priceText;
}

final List<DoctorData> doctorsData = const [
    DoctorData(
      imagePath: 'assets/images/doctor1.png',
      doctorName: 'dr. Erinna W., Sp. KJ',
      specializationAndExperience: 'Psikolog Klinis | 15 tahun',
      priceText: 'Rp60.000',
    ),
    DoctorData(
      imagePath: 'assets/images/doctor2.png',
      doctorName: 'dr. Rayhan D., Sp. KJ',
      specializationAndExperience: 'Psikolog Klinis | 11 tahun',
      priceText: 'Rp55.000',
    ),
    DoctorData(
      imagePath: 'assets/images/doctor3.png',
      doctorName: 'dr. Nabila P., M.Psi',
      specializationAndExperience: 'Psikolog Klinis | 9 tahun',
      priceText: 'Rp50.000',
    ),
    DoctorData(
      imagePath: 'assets/images/doctor4.png',
      doctorName: 'dr. Skibidi Toilet P., M.Psi',
      specializationAndExperience: 'Psikolog Kucing | 9 tahun',
      priceText: 'Rp50.000',
    ),
    DoctorData(
      imagePath: 'assets/images/doctor1.png',
      doctorName: 'dr. Sapardi Djoko P., M.Psi',
      specializationAndExperience: 'Psikolog Komputer | 9 tahun',
      priceText: 'Rp50.000',
    ),
    DoctorData(
      imagePath: 'assets/images/doctor2.png',
      doctorName: 'dr. Vario 255 P., M.Psi',
      specializationAndExperience: 'Psikolog Busi | 9 tahun',
      priceText: 'Rp50.000',
    ),
    DoctorData(
      imagePath: 'assets/images/doctor3.png',
      doctorName: 'dr. Cuma Bisa Angela P., M.Psi',
      specializationAndExperience: 'Psikolog ML | 9 tahun',
      priceText: 'Rp50.000',
    ),
    DoctorData(
      imagePath: 'assets/images/doctor4.png',
      doctorName: 'dr. Ngaku Nabi P., M.Psi',
      specializationAndExperience: 'Psikolog Surga | 9 tahun',
      priceText: 'Rp50.000',
    ),
];