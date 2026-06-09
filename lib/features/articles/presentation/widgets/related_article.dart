import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/articles/data/models/articles_model.dart';
import 'package:rafiq/features/articles/data/repositories/articles_repository.dart';
import 'package:rafiq/features/articles/presentation/bloc/articles_cubit.dart';
import 'package:rafiq/features/articles/presentation/pages/article_details_screen.dart';
import 'package:rafiq/features/articles/presentation/widgets/category_item.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';

class RelatedArticle extends StatelessWidget {
  const RelatedArticle({super.key, required this.article});

  final ArticlesModel article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => ArticleDetailsCubit(ArticleRepository()),
              child: ArticleDetailsScreen(articleId: article.id),
            ),
          ),
        );
      },
      child: CardWidget(
        horizontalPadding: 16,
        verticalPadding: 16,
        width: double.infinity,
        widget: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: SizedBox(
                height: 90.h,
                width: 90.w,
                child: Image.network(article.image, fit: BoxFit.cover),
              ),
            ),
            WidthSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.profileServicesStyle,
                  ),
                  HeightSpace(8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16.sp,
                        color: AppColors.primary,
                      ),
                      WidthSpace(4),
                      Text(
                        "${article.readTime} دقائق",
                        style: AppTypography.bodySmall,
                      ),
                      WidthSpace(12),
                      CategoryItem(
                        article: article,
                        bgcolor: AppColors.greenWhite,
                        fgcolor: AppColors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
