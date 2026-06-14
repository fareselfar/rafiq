import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_my_articles_usecase.dart';
import '../../domain/usecases/add_article_usecase.dart';
import '../../domain/usecases/delete_article_usecase.dart';
import 'doctor_articles_state.dart';

class DoctorArticlesCubit extends Cubit<DoctorArticlesState> {
  final GetMyArticlesUseCase _getMyArticles;
  final AddArticleUseCase _addArticle;
  final DeleteArticleUseCase _deleteArticle;

  DoctorArticlesCubit({
    required GetMyArticlesUseCase getMyArticles,
    required AddArticleUseCase addArticle,
    required DeleteArticleUseCase deleteArticle,
  })  : _getMyArticles = getMyArticles,
        _addArticle = addArticle,
        _deleteArticle = deleteArticle,
        super(DoctorArticlesInitial());

  Future<void> loadArticles() async {
    emit(DoctorArticlesLoading());
    try {
      final articles = await _getMyArticles();
      emit(DoctorArticlesLoaded(articles));
    } catch (e) {
      emit(DoctorArticlesError(e.toString()));
    }
  }

  Future<void> addArticle({
    required String title,
    required String content,
    required String category,
    required String shortDescription,
    File? image,
    bool publish = true,
  }) async {
    emit(AddArticleLoading());
    try {
      await _addArticle(
        title: title,
        content: content,
        category: category,
        shortDescription: shortDescription,
        image: image,
      );
      emit(AddArticleSuccess(isPublished: publish));
      loadArticles();
    } catch (e) {
      emit(AddArticleError(e.toString()));
    }
  }

  Future<void> deleteArticle(int id) async {
    emit(DeleteArticleLoading(id));
    try {
      await _deleteArticle(id);
      emit(DeleteArticleSuccess());
      loadArticles();
    } catch (e) {
      emit(DeleteArticleError(e.toString()));
    }
  }
}
