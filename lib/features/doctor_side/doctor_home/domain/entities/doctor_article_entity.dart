class DoctorArticleEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String publishedSince;
  final int viewsCount;

  const DoctorArticleEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishedSince,
    required this.viewsCount,
  });
}