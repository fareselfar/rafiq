import 'package:rafiq/features/articles/data/models/articles_model.dart';

class ArticlesListState {
  final List<ArticlesModel> articles;
  final List<ArticlesModel> filtered;
  final bool isLoading;

  ArticlesListState({
    this.articles = const [],
    this.filtered = const [],
    this.isLoading = false,
  });

  ArticlesListState copyWith({
    List<ArticlesModel>? articles,
    List<ArticlesModel>? filtered,
    bool? isLoading,
  }) {
    return ArticlesListState(
      articles: articles ?? this.articles,
      filtered: filtered ?? this.filtered,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
