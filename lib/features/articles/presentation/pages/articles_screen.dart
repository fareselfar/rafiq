import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_article_view.dart';
import 'package:rafiq/core/widgets/custom_search_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

import 'package:rafiq/features/articles/data/models/articles_filter.dart';
import 'package:rafiq/features/articles/data/models/articles_model.dart';
import 'package:rafiq/features/articles/data/repositories/articles_repository.dart';
import 'package:rafiq/features/articles/presentation/widgets/related_article.dart';
import 'package:rafiq/features/patient_side/patient_profile/presentation/widgets/classify_articles_search.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  ArticleCategory selectedCategory = ArticleCategory.all;

  List<ArticlesModel> allArticles = [];
  List<ArticlesModel> filteredArticles = [];

  @override
  void initState() {
    super.initState();
    loadArticles();
  }

  Future<void> loadArticles() async {
    final repo = ArticleRepository();
    final articles = await repo.getArticles();
    setState(() {
      allArticles = articles;
      filteredArticles = articles;
    });
  }

  void filterArticles(ArticleCategory category) {
    setState(() {
      selectedCategory = category;

      if (category == ArticleCategory.all) {
        filteredArticles = allArticles;
      } else {
        filteredArticles = allArticles
            .where((a) => a.category.trim() == category.value?.trim())
            .toList();
      }

      print("Filtered count: ${filteredArticles.length}");
    });
  }

  void search(String value) {
    setState(() {
      filteredArticles = allArticles.where((a) {
        return a.title.contains(value);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المقالات", style: AppTypography.appBarTitelStyle),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            CustomSearchField(
              hint: "البحث",
              suffixIcon: const Icon(Icons.search),
              onChanged: search,
            ),

            HeightSpace(20),
            ClassifyArticlesSearch(
              selectedCategory: selectedCategory,
              onSelect: filterArticles,
            ),
            HeightSpace(20),

            Expanded(
              child: ListView.separated(
                itemCount: filteredArticles.length,
                separatorBuilder: (_, __) => HeightSpace(16),
                itemBuilder: (context, index) {
                  final article = filteredArticles[index];

                  if (index == 0) {
                    return Column(
                      children: [
                        CustomArticleView(article: article),
                        HeightSpace(20),
                      ],
                    );
                  }

                  return RelatedArticle(article: article);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
