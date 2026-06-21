import 'dart:io';
import '../entities/article_entity.dart';

abstract class DoctorArticleRepository {
  Future<List<ArticleEntity>> getMyArticles();
  Future<void> addArticle({
    required String title,
    required String content,
    required String category,
    required String shortDescription,
    File? image,
  });
  Future<void> deleteArticle(int id);
}
