import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/articles/data/repositories/articles_repository.dart';
import 'package:rafiq/features/articles/presentation/bloc/article_list_state.dart';

class ArticlesListCubit extends Cubit<ArticlesListState> {
  final ArticleRepository repo;

  ArticlesListCubit(this.repo) : super(ArticlesListState());

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));

    final articles = await repo.getArticles();

    emit(
      state.copyWith(articles: articles, filtered: articles, isLoading: false),
    );
  }

  void search(String value) {
    final results = state.articles
        .where((a) => a.title.contains(value))
        .toList();

    emit(state.copyWith(filtered: results));
  }

  void filterByCategory(String? category) {
    if (category == null) {
      emit(state.copyWith(filtered: state.articles));
    } else {
      final filtered = state.articles
          .where((a) => a.category == category)
          .toList();

      emit(state.copyWith(filtered: filtered));
    }
  }
}
