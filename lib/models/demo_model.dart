class DemoModel {
  final String id;
  final String actorName;
  final String description;
  final List<String> tags;
  final String thumbnail;
  final String duration;
  final String performanceTitle;
  final String bio;

  const DemoModel({
    required this.id,
    required this.actorName,
    required this.description,
    required this.tags,
    required this.thumbnail,
    required this.duration,
    required this.performanceTitle,
    required this.bio,
  });
}
