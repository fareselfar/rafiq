import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/features/articles/data/models/articles_model.dart';
import 'package:rafiq/features/patient_side/patient_profile/presentation/widgets/card_widget.dart';

class YourCustomFavoriteCard extends StatelessWidget {
  final ArticlesModel article;
  final VoidCallback onRemove;

  const YourCustomFavoriteCard({
    super.key,
    required this.article,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      horizontalPadding: 16,
      verticalPadding: 16,
      width: double.infinity,
      widget: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.bookmark, color: Colors.white),
          ),

          const SizedBox(width: 12),

          /// النصوص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.title),
                const SizedBox(height: 6),
                Text(article.category),
              ],
            ),
          ),

          /// الصورة
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              article.image,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
