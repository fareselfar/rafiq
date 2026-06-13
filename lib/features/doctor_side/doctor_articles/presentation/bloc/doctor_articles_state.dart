import '../../domain/entities/article_entity.dart';

abstract class DoctorArticlesState {}

class DoctorArticlesInitial extends DoctorArticlesState {}

class DoctorArticlesLoading extends DoctorArticlesState {}

class DoctorArticlesLoaded extends DoctorArticlesState {
  final List<ArticleEntity> articles;
  DoctorArticlesLoaded(this.articles);
}

class DoctorArticlesError extends DoctorArticlesState {
  final String message;
  DoctorArticlesError(this.message);
}

// Add Article states
class AddArticleLoading extends DoctorArticlesState {}

class AddArticleSuccess extends DoctorArticlesState {
  final bool isPublished;
  AddArticleSuccess({required this.isPublished});
}

class AddArticleError extends DoctorArticlesState {
  final String message;
  AddArticleError(this.message);
}

// Delete Article states
class DeleteArticleLoading extends DoctorArticlesState {
  final int articleId;
  DeleteArticleLoading(this.articleId);
}

class DeleteArticleSuccess extends DoctorArticlesState {}

class DeleteArticleError extends DoctorArticlesState {
  final String message;
  DeleteArticleError(this.message);
}
