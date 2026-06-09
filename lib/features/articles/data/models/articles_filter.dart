enum ArticleCategory { all, nutrition, general }

extension ArticleCategoryExtension on ArticleCategory {
  String get displayName {
    switch (this) {
      case ArticleCategory.all:
        return "جميع المقالات";
      case ArticleCategory.nutrition:
        return "تغذية";
      case ArticleCategory.general:
        return "نصائح عامة";
    }
  }

  String? get value {
    switch (this) {
      case ArticleCategory.all:
        return null;
      case ArticleCategory.nutrition:
        return "تغذية";
      case ArticleCategory.general:
        return "نصائح عامة";
    }
  }
}
