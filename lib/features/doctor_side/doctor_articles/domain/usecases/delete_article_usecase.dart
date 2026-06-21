import '../repositories/doctor_article_repository.dart';

class DeleteArticleUseCase {
  final DoctorArticleRepository _repository;
  DeleteArticleUseCase(this._repository);

  Future<void> call(int id) => _repository.deleteArticle(id);
}
