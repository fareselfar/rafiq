import '../entities/article_entity.dart';
import '../repositories/doctor_article_repository.dart';

class GetMyArticlesUseCase {
  final DoctorArticleRepository _repository;
  GetMyArticlesUseCase(this._repository);

  Future<List<ArticleEntity>> call() => _repository.getMyArticles();
}
