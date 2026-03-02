import 'package:rafiq/features/articles/data/models/articles_model.dart';

class ArticleDetailsState {
  final ArticlesModel? article;
  final List<ArticlesModel> related;
  final bool isLoading;

  ArticleDetailsState({
    this.article,
    this.related = const [],
    this.isLoading = false,
  });

  ArticleDetailsState copyWith({
    ArticlesModel? article,
    List<ArticlesModel>? related,
    bool? isLoading,
  }) {
    return ArticleDetailsState(
      article: article ?? this.article,
      related: related ?? this.related,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
