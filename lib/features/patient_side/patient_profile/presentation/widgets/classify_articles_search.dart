import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/features/articles/data/models/articles_filter.dart';
import 'package:rafiq/features/patient_side/patient_profile/presentation/widgets/small_card.dart';

class ClassifyArticlesSearch extends StatelessWidget {
  final ArticleCategory selectedCategory;
  final Function(ArticleCategory) onSelect;

  const ClassifyArticlesSearch({
    super.key,
    required this.selectedCategory,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...ArticleCategory.values.map((category) {
            final isSelected = selectedCategory == category;

            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SmallCard(
                isList: true,
                title: category.displayName,
                hightPadding: 8,
                widthPadding: 8,
                bgColor: isSelected ? AppColors.primary : AppColors.surface,
                fgColor: isSelected ? Colors.white : AppColors.textSecondary,
                onTap: () => onSelect(category),
              ),
            );
          }),
        ],
      ),
    );
  }
}
//.toList()