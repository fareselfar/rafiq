import 'dart:io';
import '../repositories/doctor_article_repository.dart';

class AddArticleUseCase {
  final DoctorArticleRepository _repository;
  AddArticleUseCase(this._repository);

  Future<void> call({
    required String title,
    required String content,
    required String category,
    required String shortDescription,
    File? image,
  }) =>
      _repository.addArticle(
        title: title,
        content: content,
        category: category,
        shortDescription: shortDescription,
        image: image,
      );
}
