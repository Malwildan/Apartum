class OnboardingModel {
  final String image;
  final String title;
  final String description;

  const OnboardingModel({required this.image, required this.title, required this.description});
}

const List<OnboardingModel> onboardingData = [
  OnboardingModel(
    image: 'assets/images/onboarding1.png',
    title: 'Merawat diri setelah melahirkan itu penting',
    description: 'Apartum membantu Ibu memantau kondisi fisik, emosi, dan pola tidur bayi setiap hari agar masa pemulihan terasa lebih aman dan terarah.',
  ),
  OnboardingModel(
    image: 'assets/images/onboarding2.png',
    title: 'Catat kondisi harian dengan mudah',
    description: 'Pantau perdarahan, kondisi fisik, perasaan, dan pola tidur bayi. Semua catatan tersimpan rapi agar Ibu dapat melihat perkembangan setiap hari.',
  ),
  OnboardingModel(
    image: 'assets/images/onboarding3.png',
    title: 'Ibu tidak perlu melalui ini sendirian',
    description: 'Jika Apartum mendeteksi tanda yang perlu diperhatikan, aplikasi akan memberikan peringatan dan membantu Ibu terhubung dengan tenaga profesional.',
  ),
];