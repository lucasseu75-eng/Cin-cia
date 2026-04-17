class ActorProfile {
  final String id;
  final String name;
  final String imageUrl;
  final String ageRange;
  final String location;
  final List<String> skills;
  final String experience;
  final List<String> languages;

  const ActorProfile({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.ageRange,
    required this.location,
    required this.skills,
    this.experience = "",
    this.languages = const [],
  });
}
