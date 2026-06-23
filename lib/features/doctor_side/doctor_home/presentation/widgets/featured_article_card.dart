// lib/features/doctor_side/doctor_home/presentation/widgets/featured_article_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/extensions.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_article_entity.dart';

/// Full-width article card.
/// No textDirection overrides — RTL app handles all alignment.
/// CrossAxisAlignment.start = RIGHT alignment in RTL ✓
class FeaturedArticleCard extends StatelessWidget {
  final DoctorArticleEntity article;
  final VoidCallback? onTap;

  const FeaturedArticleCard({super.key, required this.article, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _ArticleCardShell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // RTL: start = RIGHT ✓
          children: [
            ArticleCoverImage(imageUrl: article.imageUrl),
            ArticleCardBody(article: article),
          ],
        ),
      ),
    );
  }
}

/// White card with shadow and clip
class _ArticleCardShell extends StatelessWidget {
  final Widget child;

  const _ArticleCardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

/// Cover image — 150h full width
class ArticleCoverImage extends StatelessWidget {
  final String imageUrl;

  const ArticleCoverImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      width: double.infinity,
      child: imageUrl.startsWith('http')
          ? Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const _ArticleImageFallback(),
            )
          : const _ArticleImageFallback(),
    );
  }
}

class _ArticleImageFallback extends StatelessWidget {
  const _ArticleImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightBlue,
      child: Center(
        child: Icon(
          Icons.article_outlined,
          color: AppColors.primary,
          size: 40.sp,
        ),
      ),
    );
  }
}

/// Padding wrapper for title + description + meta
class ArticleCardBody extends StatelessWidget {
  final DoctorArticleEntity article;

  const ArticleCardBody({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // RTL: start = RIGHT ✓
        children: [
          ArticleTitle(title: article.title),
          const HeightSpace(4),
          ArticleDescription(description: article.description),
          const HeightSpace(8),
          ArticleMetaRow(
            viewsCount: article.viewsCount,
            publishedSince: article.publishedSince,
          ),
        ],
      ),
    );
  }
}

/// Bold article title
class ArticleTitle extends StatelessWidget {
  final String title;

  const ArticleTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.bodymid.copyWith(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.selectedText,
      ),
    );
  }
}

/// Grey 2-line description
class ArticleDescription extends StatelessWidget {
  final String description;

  const ArticleDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppTypography.bodySmall.copyWith(
        color: AppColors.textSecondary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
    );
  }
}

/// Meta row — RTL app: children[0] on RIGHT, children[1] on LEFT
///   RIGHT: "منذ يومين 🕐"
///   LEFT:  "١.٢ ألف 👁"
class ArticleMetaRow extends StatelessWidget {
  final int viewsCount;
  final String publishedSince;

  const ArticleMetaRow({
    super.key,
    required this.viewsCount,
    required this.publishedSince,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // No textDirection override
      children: [
        // children[0] → RIGHT in RTL = time elapsed ✓
        _TimeElapsedLabel(text: publishedSince),
        const Spacer(),
        // children[1] → LEFT in RTL = views count ✓
        _ViewsCountLabel(count: viewsCount),
      ],
    );
  }
}

/// "🕐 منذ يومين"
class _TimeElapsedLabel extends StatelessWidget {
  final String text;

  const _TimeElapsedLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.access_time_rounded,
          size: 14.sp,
          color: AppColors.textSecondary,
        ),
        const WidthSpace(4),
        Text(
          text,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _ViewsCountLabel extends StatelessWidget {
  final int count;

  const _ViewsCountLabel({required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.remove_red_eye_outlined,
          size: 14.sp,
          color: AppColors.primary,
        ),
        const WidthSpace(4),
        Text(
          count.toKFormat(),
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.primary,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
