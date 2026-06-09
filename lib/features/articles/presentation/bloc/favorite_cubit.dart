import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/articles/data/models/articles_model.dart';
import 'package:rafiq/features/articles/data/repositories/articles_repository.dart';

class FavoriteCubit extends Cubit<List<ArticlesModel>> {
  final ArticleRepository repo;

  FavoriteCubit(this.repo) : super([]);

  void loadFavorites() {
    emit(repo.getSavedArticles());
  }

  void remove(int id) {
    repo.removeFromFavorites(id);
    emit(repo.getSavedArticles());
  }
}
