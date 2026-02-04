import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ملف الطبيب'),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SizedBox(
          width: size.width,
          child: ListView(
            children: [
              HeightSpace(20.h),
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/doc.jpg'),
                  ),
                  HeightSpace(8.h),
                  Text(
                    'د. محمد على',
                    style: TextStyle(
                      color: AppColors.textLabel,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'أخصائى قلب',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  HeightSpace(8.h),
                  Text(
                    '⭐ 4.5 (320 مراجعة)',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.selectedText,
                    ),
                  ),
                  HeightSpace(8.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/location.svg',
                        width: 16.w,
                        height: 16.h,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'طنطا – أول شارع البحر',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: AppColors.selectedText,
                        ),
                      ),
                    ],
                  ),
                  HeightSpace(8.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'سعر الكشف : ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: AppColors.selectedText,
                        ),
                      ),
                      Text(
                        '150 جنيه',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              HeightSpace(20.h),
              Row(
                children: [
                  CustomDetailsContainer(
                    iconPath: 'assets/icons/details2.svg',
                    title: '+8',
                    subTitle: 'سنوات خبره',
                  ),
                  WidthSpace(12.w),
                  CustomDetailsContainer(
                    iconPath: 'assets/icons/details1.svg',
                    title: '+500',
                    subTitle: 'مريض',
                  ),
                  WidthSpace(12.w),
                  CustomDetailsContainer(
                    iconPath: 'assets/icons/details3.svg',
                    title: '15د',
                    subTitle: 'مده الانتظار',
                  ),
                ],
              ),
              HeightSpace(20.h),
              Text(
                'نبذة عن الطبيب',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.selectedText,
                ),
              ),
              HeightSpace(8.h),
              Text(
                'طبيب متخصص في علاج أمراض وإصابات العظام والمفاصل والعمود الفقري. حاصل على تدريب معتمد في تشخيص وعلاج الكسور، آلام الظهر والرقبة، خشونة المفاصل، وإصابات الملاعب. يهتم بمتابعة حالات ما بعد الجراحة وبرامج التأهيل الحركي، ويتمتع بخبرة واسعة في التعامل مع الحالات الطارئة وتقديم رعاية طبية متكاملة تهدف إلى استعادة الحركة وتقليل الألم وتحسين جودة حياة المرضى.',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.selectedText,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: CustomButton(
          text: 'احجز الآن',
          onPressed: () {},
          height: 50.h,
          width: 328.w,
        ),
      ),
    );
  }
}

class CustomDetailsContainer extends StatelessWidget {
  const CustomDetailsContainer({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subTitle,
  });
  final String iconPath;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 104.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, height: 60.h, width: 60.w),
          HeightSpace(8.h),
          Text(
            title,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          HeightSpace(8.h),
          Text(
            subTitle,
            style: TextStyle(
              color: AppColors.selectedText.withOpacity(0.8),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
