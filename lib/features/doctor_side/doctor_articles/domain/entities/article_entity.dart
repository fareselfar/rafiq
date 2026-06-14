class ArticleEntity {
  final int id;
  final String title;
  final String content;
  final String imagePath;
  final String category;
  final String timeAge;
  final bool isPublished;

  const ArticleEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.imagePath,
    required this.category,
    required this.timeAge,
    required this.isPublished,
  });
}
