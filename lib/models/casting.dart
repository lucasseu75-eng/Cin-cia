class Casting {
  final String id;
  final String title;
  final String type;
  final String location;
  final String imageUrl;
  final double rating;
  final String reviewsCountText;
  final bool isUrgent;
  final List<String> tags;

  const Casting({
    required this.id,
    required this.title,
    required this.type,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCountText,
    this.isUrgent = false,
    required this.tags,
  });
}
