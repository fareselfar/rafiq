import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/custom_article_view.dart';

import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_search_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/articles/data/models/articles_model.dart';
import 'package:rafiq/features/patient_home/data/models/patient_time_model.dart';
import 'package:rafiq/features/patient_home/presentation/widgets/classify_widget.dart';
import 'package:rafiq/features/patient_home/presentation/widgets/custom_text_button.dart';
import 'package:rafiq/features/patient_home/presentation/widgets/gradient_card.dart';
import 'package:rafiq/features/patient_home/presentation/widgets/patient_time.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_cubit.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_state.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  final article = ArticlesModel(
    id: 1,
    title: "نصائح للحفاظ على صحة القلب",
    image: "https://i.imgur.com/8Km9tLL.jpg",
    category: "تغذية",
    readTime: 10,
    authorName: "د/ خالد محمد",
    authorImage: "https://i.pravatar.cc/150?img=3",
    content: [
      ArticleSection(
        title: "التغذية السليمة",
        description:
            "التغذية السليمة هي الأساس للحفاظ على صحة القلب وتقليل خطر الإصابة بالأمراض القلبية.",
      ),
      ArticleSection(
        title: "ممارسة الرياضة",
        description:
            "ممارسة الرياضة بانتظام تحسن الدورة الدموية وتقوي عضلة القلب.",
      ),
    ],
  );
  @override
  void initState() {
    super.initState();

    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              return Text(state.profile.fullName);
            }

            return const Text('...');
          },
        ),
        leading: Padding(
          padding: REdgeInsets.only(top: 8, bottom: 8),
          child: SvgPicture.asset(SvgManger.profile),
        ),
        leadingWidth: 65.w,
        titleSpacing: -10,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.selectedText,
              size: 30,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('أهلًا، كيف نقدر', style: AppTypography.homeTitle),
                    Text('نساعدك اليوم؟', style: AppTypography.homeSubTitle),
                    HeightSpace(16),
                    GestureDetector(
                      onTap: () {
                        context.navigateTo(Routes.homeSearchScreen);
                      },
                      child: CustomSearchField(
                        hint: 'البحث',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              HeightSpace(20),

              Container(
                decoration: BoxDecoration(color: AppColors.surface),
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'التخصصات الشائعة',
                            style: AppTypography.profileServicesStyle,
                          ),
                          Spacer(),
                          CustomTextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.specializationScreen,
                              );
                            },
                            text: 'عرض الكل',
                          ),
                        ],
                      ),
                      HeightSpace(20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ClassifyWidget(
                              bgColor: AppColors.greenWhite,
                              fgColor: AppColors.selectedDoctor,
                              icon: SvgManger.baby,
                              text: 'اطفال',
                              onTap: () {},
                            ),
                            WidthSpace(16),
                            ClassifyWidget(
                              bgColor: AppColors.pinkWhite,
                              fgColor: AppColors.pink,
                              icon: SvgManger.women,
                              text: 'نساء وتوليد',
                              onTap: () {},
                            ),
                            WidthSpace(16),
                            ClassifyWidget(
                              bgColor: AppColors.redWhite,
                              fgColor: AppColors.red,
                              icon: SvgManger.heart,
                              text: 'قلب',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      HeightSpace(52),
                      GradientCard(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 32.h,
                            horizontal: 22.w,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "مش عارف تختار التخصص؟\nرفيق يساعدك!",
                                style: AppTypography.chatbotTitle,
                                textAlign: TextAlign.center,
                              ),

                              HeightSpace(8),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'احكي لرفيق أعراضك،\n وهو يرشّح لك التخصص المناسب',
                                            style: AppTypography.chatSubTitle,
                                            textAlign: TextAlign.center,
                                          ),

                                          HeightSpace(20),
                                          CustomButton(
                                            text: 'ابدأ التشخيص المبدئي',
                                            onPressed: () {
                                              context.navigateTo(
                                                '/chatBotScreen',
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  WidthSpace(6),
                                  Image.asset(
                                    AssetsManger.smileBot,
                                    height: 160.h,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      HeightSpace(20),
                      // DoctorsWidget(
                      //   doctorModel: DoctorModel(
                      //     image: AssetsManger.doctor,
                      //     doctorName: 'د.محمد علي عبد العزيز',
                      //     doctorSpecialization: 'أخصائي عظام',
                      //     doctorRate: '4.9 ',
                      //     doctorLocation: 'طنطا – أول شارع البحر',
                      //     doctorPrice: '150 جنيه',
                      //     onTap: () {},
                      //   ),
                      // ),
                      HeightSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'مواعيدي القادمة',
                            style: AppTypography.profileServicesStyle,
                          ),
                          CustomTextButton(onPressed: () {}, text: 'عرض الكل'),
                        ],
                      ),
                      HeightSpace(20),
                      PatientTime(
                        patientTimeModel: PatientTimeModel(
                          img: AssetsManger.doctor,
                          rate: '4.5',
                          doctorName: 'د.محمد علي عبد العزيز',
                          location: 'طنطا – أول شارع البحر',
                          date: 'الاحد , 10 يناير 2026',
                          time: '10 صباحا',
                          specialization: 'أخصائي عظام',
                        ),
                      ),
                      HeightSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'المقالات',
                            style: GoogleFonts.changa(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.selectedText,
                            ),
                          ),
                          CustomTextButton(
                            onPressed: () {
                              context.navigateTo(Routes.articlesScreen);
                            },
                            text: 'عرض الكل',
                          ),
                        ],
                      ),
                      CustomArticleView(article: article),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
