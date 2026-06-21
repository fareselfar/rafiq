import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/presentation/bloc/doctor_articles_cubit.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/presentation/bloc/doctor_articles_state.dart';
import '../widgets/doctor_article_card.dart';
import '../widgets/delete_article_dialog.dart';
import '../widgets/article_stat_card.dart';
import '../widgets/article_success_dialog.dart';
import 'add_article_screen.dart';

class DoctorArticlesScreen extends StatefulWidget {
  const DoctorArticlesScreen({super.key});

  @override
  State<DoctorArticlesScreen> createState() => _DoctorArticlesScreenState();
}

class _DoctorArticlesScreenState extends State<DoctorArticlesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorArticlesCubit>().loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: BlocConsumer<DoctorArticlesCubit, DoctorArticlesState>(
        listener: (context, state) {
          if (state is DeleteArticleSuccess) {
            showDialog(
              context: context,
              builder: (_) => const ArticleSuccessDialog(message: 'تم الحذف'),
            );
          }
          if (state is DeleteArticleError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              _buildAppBar(context),
              if (state is DoctorArticlesLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state is DoctorArticlesError)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      state.message,
                      style: GoogleFonts.cairo(color: AppColors.red),
                    ),
                  ),
                )
              else if (state is DoctorArticlesLoaded) ...[
                _buildStatsSection(state),
                _buildArticlesList(context, state),
              ],
            ],
          );
        },
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.backGround,
      floating: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'المقالات',
            style: GoogleFonts.cairo(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<DoctorArticlesCubit>(),
                  child: const AddArticleScreen(),
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.white, size: 18.sp),
                  const WidthSpace(4),
                  Text(
                    'اضافة مقال',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildStatsSection(DoctorArticlesLoaded state) {
    final published = state.articles.where((a) => a.isPublished).length;
    final drafts = state.articles.where((a) => !a.isPublished).length;

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            ArticleStatCard(
              title: 'قراءات الشهر',
              value: '00,000 مشاهده',
              icon: Icons.visibility_outlined,
              iconBgColor: Colors.blue.shade50,
              iconColor: Colors.blue,
            ),
            const HeightSpace(10),
            ArticleStatCard(
              title: 'مقالات منشورة',
              value: published.toString(),
              icon: Icons.article_outlined,
              iconBgColor: Colors.green.shade50,
              iconColor: Colors.green,
            ),
            const HeightSpace(10),
            ArticleStatCard(
              title: 'مسودات',
              value: drafts.toString(),
              icon: Icons.edit_note_outlined,
              iconBgColor: Colors.grey.shade100,
              iconColor: Colors.grey.shade700,
            ),
            const HeightSpace(8),
          ],
        ),
      ),
    );
  }

  SliverList _buildArticlesList(
    BuildContext context,
    DoctorArticlesLoaded state,
  ) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final article = state.articles[index];
        return DoctorArticleCard(
          article: article,
          onEdit: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<DoctorArticlesCubit>(),
                child: AddArticleScreen(articleToEdit: article),
              ),
            ),
          ),
          onDelete: () => showDialog(
            context: context,
            builder: (_) => DeleteArticleDialog(
              onConfirm: () =>
                  context.read<DoctorArticlesCubit>().deleteArticle(article.id),
            ),
          ),
          onPublish: !article.isPublished
              ? () {
                  // Publish draft: re-submit via edit
                }
              : null,
        );
      }, childCount: state.articles.length),
    );
  }
}
