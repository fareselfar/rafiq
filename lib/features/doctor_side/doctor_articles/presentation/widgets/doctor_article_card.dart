import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import '../../domain/entities/article_entity.dart';

class DoctorArticleCard extends StatelessWidget {
  final ArticleEntity article;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onPublish;
  final VoidCallback onTap;

  const DoctorArticleCard({
    super.key,
    required this.article,
    required this.onEdit,
    required this.onDelete,
    this.onPublish,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDraft = !article.isPublished;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Article info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: AppTypography.profileNameStyle.copyWith(fontSize: 15.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const HeightSpace(6),
                      Row(
                        children: [
                          _CategoryChip(label: article.category),
                          const WidthSpace(8),
                          Icon(Icons.access_time_rounded,
                              size: 14.sp, color: AppColors.textSecondary),
                          const WidthSpace(4),
                          Text(
                            article.timeAge,
                            style: GoogleFonts.cairo(
                              fontSize: 12.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const WidthSpace(12),
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: article.imagePath.isNotEmpty
                      ? Image.network(
                          article.imagePath,
                          width: 72.w,
                          height: 72.h,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _PlaceholderImage(),
                        )
                      : _PlaceholderImage(),
                ),
              ],
            ),
            if (isDraft) ...[
              const HeightSpace(4),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: _DraftBadge(),
              ),
            ],
            const HeightSpace(10),
            const Divider(height: 1),
            const HeightSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isDraft && onPublish != null)
                  _ActionChip(
                    label: 'نشر',
                    color: AppColors.primary,
                    icon: Icons.publish_rounded,
                    onTap: onPublish!,
                    filled: true,
                  ),
                if (isDraft && onPublish != null) const WidthSpace(8),
                _ActionChip(
                  label: 'تعديل',
                  color: AppColors.textPrimary,
                  icon: Icons.edit_outlined,
                  onTap: onEdit,
                ),
                const WidthSpace(8),
                _ActionChip(
                  label: 'حذف',
                  color: AppColors.red,
                  icon: Icons.delete_outline_rounded,
                  onTap: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.cairo(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _DraftBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        'مسوده',
        style: GoogleFonts.cairo(
          fontSize: 11.sp,
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  const _ActionChip({
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: filled ? color : color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15.sp, color: filled ? Colors.white : color),
            const WidthSpace(4),
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: filled ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      color: Colors.grey.shade200,
      child: Icon(Icons.image_outlined, color: Colors.grey.shade400),
    );
  }
}
