import 'dart:io';
import 'package:dio/dio.dart';
import '../models/article_model.dart';

abstract class DoctorArticleRemoteDatasource {
  Future<List<ArticleModel>> getMyArticles();
  Future<void> addArticle({
    required String title,
    required String content,
    required String category,
    required String shortDescription,
    File? image,
  });
  Future<void> deleteArticle(int id);
}

class DoctorArticleRemoteDatasourceImpl
    implements DoctorArticleRemoteDatasource {
  final Dio _dio;
  DoctorArticleRemoteDatasourceImpl(this._dio);

  @override
  Future<List<ArticleModel>> getMyArticles() async {
    final response = await _dio.get('/Article/MyArticles');
    final list = response.data as List<dynamic>;
    return list
        .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addArticle({
    required String title,
    required String content,
    required String category,
    required String shortDescription,
    File? image,
  }) async {
    final formData = FormData.fromMap({
      'Title': title,
      'Content': content,
      'Category': category,
      'ShortDescription': shortDescription,
      if (image != null)
        'ProfileImage': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
    });
    await _dio.post('/Article/AddArticle', data: formData);
  }

  @override
  Future<void> deleteArticle(int id) async {
    await _dio.delete('/Article/DeleteArticle/$id');
  }
}
