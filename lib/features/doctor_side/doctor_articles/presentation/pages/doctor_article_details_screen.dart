import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/presentation/bloc/doctor_articles_cubit.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/presentation/bloc/doctor_articles_state.dart';
import '../../domain/entities/article_entity.dart';
import '../widgets/article_success_dialog.dart';
import '../widgets/delete_article_dialog.dart';
import 'add_article_screen.dart';

class DoctorArticleDetailsScreen extends StatelessWidget {
  final ArticleEntity article;
  const DoctorArticleDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: AppBar(
        backgroundColor: AppColors.backGround,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'تفاصيل المقال',
          style: GoogleFonts.cairo(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: BlocConsumer<DoctorArticlesCubit, DoctorArticlesState>(
        listener: (context, state) {
          if (state is DeleteArticleSuccess) {
            showDialog(
              context: context,
              builder: (_) => const ArticleSuccessDialog(message: 'تم الحذف'),
            ).then((_) => Navigator.pop(context));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 14.sp,
                            color: AppColors.textSecondary,
                          ),
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
                      const WidthSpace(12),
                      _CategoryBadge(label: article.category),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    article.title,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const HeightSpace(12),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 18.r,
                        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                        child: Icon(
                          Icons.person,
                          color: AppColors.primary,
                          size: 20.sp,
                        ),
                      ),
                      const WidthSpace(8),
                      Text(
                        'د. فارس محفوظ الفار',
                        style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const HeightSpace(16),

                // Action buttons
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'حذف',
                          type: ButtonType.outlined,
                          borderColor: AppColors.red,
                          textColor: AppColors.red,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (_) => DeleteArticleDialog(
                              onConfirm: () => context
                                  .read<DoctorArticlesCubit>()
                                  .deleteArticle(article.id),
                            ),
                          ),
                        ),
                      ),
                      const WidthSpace(12),
                      Expanded(
                        child: CustomButton(
                          text: 'تعديل المقال',
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<DoctorArticlesCubit>(),
                                child: AddArticleScreen(articleToEdit: article),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const HeightSpace(16),

                // Cover image
                if (article.imagePath.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        article.imagePath,
                        width: double.infinity,
                        height: 200.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const HeightSpace(20),

                // Content
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    article.content,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      height: 1.8,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const HeightSpace(32),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final String label;
  const _CategoryBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.cairo(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
