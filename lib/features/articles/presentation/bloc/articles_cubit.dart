import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/articles/data/repositories/articles_repository.dart';
import 'articles_state.dart';

class ArticleDetailsCubit extends Cubit<ArticleDetailsState> {
  final ArticleRepository repo;

  ArticleDetailsCubit(this.repo) : super(ArticleDetailsState());

  Future<void> load(int id) async {
    emit(state.copyWith(isLoading: true));

    final article = await repo.getArticleById(id);
    final all = await repo.getArticles();

    final related = all
        .where((a) => a.category == article.category && a.id != article.id)
        .toList();
    print("Related count: ${related.length}");
    final updatedArticle = article.copyWith(isSaved: repo.isSaved(article.id));

    emit(
      state.copyWith(
        article: updatedArticle,
        related: related,
        isLoading: false,
      ),
    );
  }

  void toggleSave() {
    if (state.article == null) return;

    repo.toggleSave(state.article!);

    final updated = state.article!.copyWith(
      isSaved: repo.isSaved(state.article!.id),
    );

    emit(state.copyWith(article: updated));
  }
}
