class ArticlesModel {
  final int id;
  final String title;
  final String image;
  final String category;
  final int readTime;
  final String authorName;
  final String authorImage;
  final List<ArticleSection> content;
  final bool isSaved;

  ArticlesModel({
    required this.id,
    required this.title,
    required this.image,
    required this.category,
    required this.readTime,
    required this.authorName,
    required this.authorImage,
    required this.content,
    this.isSaved = false,
  });

  ArticlesModel copyWith({bool? isSaved}) {
    return ArticlesModel(
      id: id,
      title: title,
      image: image,
      category: category,
      readTime: readTime,
      authorName: authorName,
      authorImage: authorImage,
      content: content,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

class ArticleSection {
  final String title;
  final String description;

  ArticleSection({required this.title, required this.description});
}
