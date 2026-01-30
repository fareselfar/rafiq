// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rafiq/core/enums/user_type.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/onbording/models/onboarding_model.dart';
import 'package:rafiq/features/onbording/widget/onboarding_item.dart';

class OnboardingScreen extends StatefulWidget {
  final UserType? selectedUserType;
  const OnboardingScreen({super.key, required this.selectedUserType});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  List<OnboardingModel> _getPages() {
    if (widget.selectedUserType == UserType.patient) {
      return [
        OnboardingModel(
          title: "شخّص أعراضك بسهولة",
          description:
              "يعتمد التطبيق على الذكاء الاصطناعي لمساعدتك\nفي فهم حالتك الصحية خلال ثوانٍ.",
          imagePath: "assets/images/onbording_patient_1.png",
        ),
        OnboardingModel(
          title: "اعثر على أفضل الأطباء",
          description:
              "اختر من الأطباء الأقرب لك والأعلى تقييماً حسب\nالتخصص الذي يناسب حالتك الصحية.",
          imagePath: "assets/images/onbording_patient_2.png",
        ),
        OnboardingModel(
          title: "اختر مواعيدك بسهولة",
          description:
              "إدارة مواعيدك، وتحاليلك، وتقاريرك الطبية في\nمكان واحد وبطريقة منظمة وسهلة.",
          imagePath: "assets/images/onbording_patient_3.png",
        ),
      ];
    } else {
      return [
        OnboardingModel(
          title: "إدارة مواعيدك بسهولة",
          description:
              "تحكم في جدولك الطبي، قبول المواعيد وتنظيم\nيومك المهني بكل سهولة من خلال واجهة\nبسيطة.",
          imagePath: "assets/images/onbording_doctor_1.png",
        ),
        OnboardingModel(
          title: "اعرض خبراتك لمرضى أكثر",
          description:
              "فعّل حسابك، ارفع شهاداتك، وقدم خبراتك الطبية\nلزيادة ظهورك وجذب مرضى جدد بسهولة.",
          imagePath: "assets/images/onbording_doctor_2.png",
        ),
        OnboardingModel(
          title: "شارك خبراتك الطبية",
          description:
              "انشر مقالاتك ونصائحك لزيادة تواجدك الطبي،\nوبناء ثقة أقوى مع المرضى.",
          imagePath: "assets/images/onbording_doctor_3.png",
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<OnboardingModel> pages = _getPages();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 9.h),
                child: TextButton(
                  onPressed: () => _navigateToAuth(),
                  child: Text(
                    "تخطي",
                    style: AppTypography.button.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // الـ Slider الرئيسي
            Expanded(
              //  flex: 5,
              child: CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: pages.length,
                itemBuilder: (context, index, realIndex) {
                  return OnboardingItem(model: pages[index]);
                },
                options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() => _currentIndex = index);
                  },
                ),
              ),
            ),

            
            // (Dots Indicator)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: DotsIndicator(
                dotsCount: pages.length,
                position: _currentIndex.toDouble(),

                decorator: DotsDecorator(
                  spacing: EdgeInsets.symmetric(horizontal: 3.w),
                  size: Size(29.w, 4.5.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Colors.grey.shade300,

                  activeSize: Size(29.w, 4.5.h),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  activeColor: AppColors.primary,
                ),
              ),
            ),

            const HeightSpace(10),
            Padding(
              padding: EdgeInsets.only(bottom: 9.h, top: 9.h),
              child: CustomButton(
                onPressed: () {
                  if (_currentIndex == pages.length - 1) {
                    _navigateToAuth();
                  } else {
                    _carouselController.nextPage();
                  }
                },

                text: _currentIndex == pages.length - 1
                    ? "ابدأ الآن"
                    : "التالي",
                textStyle: AppTypography.button,
                width: 237.w,
                height: 52.h,
                borderRadius: 8.r,
              ),
            ),
            const HeightSpace(70),
          ],
        ),
      ),
    );
  }

  void _navigateToAuth() {
    context.navigateAndReplace(
      '/getStart',
    );
  }

  // void _navigateToAuth() {
  //   context.navigateAndReplace(
  //     widget.selectedUserType == UserType.patient
  //         ? AppRouter.patientAuth
  //         : AppRouter.doctorAuth,
  //   );
  // }
}
