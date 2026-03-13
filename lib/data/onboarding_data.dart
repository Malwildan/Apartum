class OnboardingItem {
  final String title;
  final String description;

  const OnboardingItem({required this.title, required this.description});
}

const List<OnboardingItem> OnboardingText = [
  OnboardingItem(
    title: 'Merawat diri setelah\nmelahirkan itu penting',
    description:
        'Apartum membantu Ibu memantau kondisi fisik, emosi, dan pola tidur bayi setiap hari agar masa pemulihan terasa lebih aman dan terarah.',
  ),
  OnboardingItem(
    title: 'Catat kondisi harian\ndengan mudah',
    description:
      'Pantau perdarahan, kondisi fisik, perasaan, dan pola tidur bayi. Semua catatan tersimpan rapi agar Ibu dapat melihat perkembangan setiap hari.',
  ),
  OnboardingItem(
    title: 'Ibu tidak perlu melalui\nini sendirian',
    description:
        'Jika Apartum mendeteksi tanda yang perlu diperhatikan, aplikasi akan memberikan peringatan dan membantu Ibu terhubung dengan tenaga profesional.',
  ),
];
