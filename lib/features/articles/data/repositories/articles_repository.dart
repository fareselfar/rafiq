import 'package:rafiq/features/articles/data/datasources/articles_remote_datasource.dart';
import 'package:rafiq/features/articles/data/models/articles_model.dart';

class ArticleRepository {
  static final ArticleRepository _instance = ArticleRepository._internal();

  factory ArticleRepository() => _instance;

  ArticleRepository._internal();

  final ArticleRemoteDataSource remote = ArticleRemoteDataSource();

  final List<ArticlesModel> _savedArticles = [];

  Future<List<ArticlesModel>> getArticles() {
    return remote.getArticles();
  }

  Future<ArticlesModel> getArticleById(int id) {
    return remote.getArticleById(id);
  }

  List<ArticlesModel> getSavedArticles() {
    return _savedArticles;
  }

  void toggleSave(ArticlesModel article) {
    final exists = _savedArticles.any((a) => a.id == article.id);

    if (exists) {
      _savedArticles.removeWhere((a) => a.id == article.id);
    } else {
      _savedArticles.add(article.copyWith(isSaved: true));
    }
  }

  bool isSaved(int id) {
    return _savedArticles.any((a) => a.id == id);
  }

  void removeFromFavorites(int id) {
    _savedArticles.removeWhere((a) => a.id == id);
  }
}
