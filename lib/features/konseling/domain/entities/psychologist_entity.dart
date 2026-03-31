class PsychologistEntity {
  final String id;
  final String name;
  final String title;
  final String job;
  final int experienceYears;
  final num priceIdr; // Using num just in case the API ever returns decimal/double JSON types
  final String photoUrl;

  const PsychologistEntity({
    required this.id,
    required this.name,
    required this.title,
    required this.job,
    required this.experienceYears,
    required this.priceIdr,
    required this.photoUrl,
  });
}
