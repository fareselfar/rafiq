import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_article_entity.dart';

class DoctorArticleModel extends DoctorArticleEntity {
  const DoctorArticleModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.publishedSince,
    required super.viewsCount,
  });

  factory DoctorArticleModel.fromJson(Map<String, dynamic> json) {
    return DoctorArticleModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      publishedSince: json['published_since'] as String? ?? '',
      viewsCount: json['views_count'] as int? ?? 0,
    );
  }
}
