import 'dart:io';
import 'package:rafiq/features/doctor_side/doctor_articles/data/datasources/doctor_article_remote_datasource.dart';

import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/doctor_article_repository.dart';

class DoctorArticleRepositoryImpl implements DoctorArticleRepository {
  final DoctorArticleRemoteDatasource _datasource;
  DoctorArticleRepositoryImpl(this._datasource);

  @override
  Future<List<ArticleEntity>> getMyArticles() => _datasource.getMyArticles();

  @override
  Future<void> addArticle({
    required String title,
    required String content,
    required String category,
    required String shortDescription,
    File? image,
  }) =>
      _datasource.addArticle(
        title: title,
        content: content,
        category: category,
        shortDescription: shortDescription,
        image: image,
      );

  @override
  Future<void> deleteArticle(int id) => _datasource.deleteArticle(id);
}
