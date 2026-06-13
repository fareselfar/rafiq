import '../../domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required super.id,
    required super.title,
    required super.content,
    required super.imagePath,
    required super.category,
    required super.timeAge,
    required super.isPublished,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json['id'] as int,
        title: json['title'] as String? ?? '',
        content: json['content'] as String? ?? '',
        imagePath: json['imagePath'] as String? ?? '',
        category: json['category'] as String? ?? '',
        timeAge: json['timeAge'] as String? ?? '',
        isPublished: json['isPublished'] as bool? ?? true,
      );
}
