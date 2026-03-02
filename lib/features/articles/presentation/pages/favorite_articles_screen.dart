import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/articles/data/models/articles_model.dart';
import 'package:rafiq/features/articles/data/repositories/articles_repository.dart';
import 'package:rafiq/features/articles/presentation/bloc/favorite_cubit.dart';
import 'package:rafiq/features/articles/presentation/widgets/custom_favorite_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteCubit(ArticleRepository())..loadFavorites(),
      child: BlocBuilder<FavoriteCubit, List<ArticlesModel>>(
        builder: (context, favorites) {
          if (favorites.isEmpty) {
            return const Center(child: Text("لا يوجد مقالات محفوظة"));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final article = favorites[index];

              return YourCustomFavoriteCard(
                article: article,
                onRemove: () {
                  context.read<FavoriteCubit>().remove(article.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
