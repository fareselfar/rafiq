import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/articles/presentation/bloc/articles_cubit.dart';
import 'package:rafiq/features/articles/presentation/bloc/articles_state.dart';
import 'package:rafiq/features/articles/presentation/widgets/category_item.dart';
import 'package:rafiq/features/articles/presentation/widgets/related_article.dart';
import 'package:rafiq/features/profile/presentation/widgets/card_widget.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final int articleId;

  const ArticleDetailsScreen({super.key, required this.articleId});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  void initState() {
    context.read<ArticleDetailsCubit>().load(widget.articleId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تفاصيل المقال")),
      body: SafeArea(
        child: BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final article = state.article;
            if (article == null) return const SizedBox();

            return Padding(
              padding: REdgeInsets.symmetric(horizontal: 17),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        article.image,
                        height: 220.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Padding(
                      padding: REdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CategoryItem(
                                article: article,
                                bgcolor: AppColors.greenWhite,
                                fgcolor: AppColors.green,
                              ),
                              WidthSpace(20),
                              Text(
                                "${article.readTime} دقائق",
                                style: AppTypography.bodySmall,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<ArticleDetailsCubit>()
                                      .toggleSave();
                                },
                                child: CardWidget(
                                  widget: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.file_copy,
                                        color: AppColors.surface,
                                      ),
                                      Text(
                                        "حفظ المقال",
                                        style: AppTypography.saveArticle,
                                      ),
                                    ],
                                  ),
                                  horizontalPadding: 16,
                                  verticalPadding: 9,
                                  bgColor: AppColors.divider,
                                ),
                              ),
                            ],
                          ),

                          HeightSpace(8),

                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  article.authorImage,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                article.authorName,
                                style: AppTypography.bodySmall,
                              ),
                            ],
                          ),

                          ...article.content.asMap().entries.map((entry) {
                            final index = entry.key;
                            final section = entry.value;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  section.title,
                                  style: AppTypography.profileServicesStyle,
                                ),

                                HeightSpace(16),
                                if (index == 2) ...[
                                  CardWidget(
                                    bgColor: AppColors.note,
                                    borderColor: AppColors.info,
                                    borderWidth: 2,
                                    widget: Padding(
                                      padding: REdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 19,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.info_outline,
                                            color: AppColors.info,
                                            size: 30.sp,
                                          ),
                                          WidthSpace(20),
                                          Expanded(
                                            child: Text(
                                              "تناول السمك مرتين إلى ثلاث مرات أسبوعيًا يساعد على تحسين صحة القلب لأنه غني بأوميغا 3.",
                                              style: AppTypography.inputHint,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  HeightSpace(16),
                                ],

                                Text(
                                  section.description,
                                  style: AppTypography.inputTextFormStyle,
                                ),

                                const SizedBox(height: 20),
                              ],
                            );
                          }),

                          HeightSpace(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "مقالات ذات صلة",
                                style: AppTypography.profileServicesStyle,
                              ),
                            ],
                          ),
                          ...state.related.map((relatedArticle) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: RelatedArticle(article: relatedArticle),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
