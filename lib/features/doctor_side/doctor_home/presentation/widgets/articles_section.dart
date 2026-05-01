// lib/features/doctor_side/doctor_home/presentation/widgets/articles_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_article_entity.dart';
import '../../domain/entities/doctor_home_entity.dart';
import 'doctor_section_header.dart';
import 'featured_article_card.dart';

class ArticlesSection extends StatelessWidget {
  final List<DoctorArticleEntity> articles;
  final VoidCallback? onAddArticle;
  final VoidCallback? onViewAll;

  const ArticlesSection({
    super.key,
    required this.articles,
    this.onAddArticle,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DoctorSectionHeader(
          title: 'المقالات',
          trailing: _ArticlesHeaderActions(
            onAddArticle: onAddArticle,
            onViewAll: onViewAll,
          ),
        ),
        const HeightSpace(14),
        articles.isEmpty
            ? const _EmptyArticlesWidget()
            : _ArticlesList(articles: articles),
      ],
    );
  }
}

/// Row of two small chips: ["عرض الكل" outlined] + ["+ إضافة مقال" filled]
class _ArticlesHeaderActions extends StatelessWidget {
  final VoidCallback? onAddArticle;
  final VoidCallback? onViewAll;

  const _ArticlesHeaderActions({this.onAddArticle, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ViewAllChipButton(onPressed: onViewAll),
        const WidthSpace(8),
        _AddArticleChipButton(onPressed: onAddArticle),
      ],
    );
  }
}

/// "عرض الكل" — outlined chip using CustomButton
class _ViewAllChipButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _ViewAllChipButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'عرض الكل',
      onPressed: onPressed,
      type: ButtonType.outlined,
      width: 80.w,
      height: 32.h,
      borderColor: AppColors.primary,
      borderRadius: 20,
      borderWidth: 1.5,
      textStyle: TextStyle(
        color: AppColors.primary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

/// "+ إضافة مقال" — filled primary chip using CustomButton
/// The "+" is embedded in the text since CustomButton supports svgIconPath only.
/// text: '+ إضافة مقال' gives the same visual as the design.
class _AddArticleChipButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _AddArticleChipButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: '+ إضافة مقال',
      onPressed: onPressed,
      type: ButtonType.filled,
      width: 120.w,
      height: 32.h,
      backgroundColor: AppColors.primary,
      borderRadius: 20,
      elevation: 0,
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

/// Vertical list of full-width article cards
class _ArticlesList extends StatelessWidget {
  final List<DoctorArticleEntity> articles;

  const _ArticlesList({required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      separatorBuilder: (_, __) => const HeightSpace(12),
      itemBuilder: (_, i) => FeaturedArticleCard(article: articles[i]),
    );
  }
}

class _EmptyArticlesWidget extends StatelessWidget {
  const _EmptyArticlesWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Text(
          'لا توجد مقالات حتى الآن',
          style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}