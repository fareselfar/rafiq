import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_search_field.dart';

class DoctorsSearchScreen extends StatefulWidget {
  const DoctorsSearchScreen({super.key});

  @override
  State<DoctorsSearchScreen> createState() => _DoctorsSearchScreenState();
}

class _DoctorsSearchScreenState extends State<DoctorsSearchScreen> {
  List<String> taps = ['الأقرب', 'الأكثر تقييما', 'المتاح اليوم '];
  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(title: const Text('الأطباء')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: taps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = index;
                          });
                        },
                        child: Container(
                          width: 83.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: isSelected == index
                                ? AppColors.primary
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(
                              color: isSelected == index
                                  ? AppColors.primary
                                  : AppColors.border,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              taps[index],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: isSelected == index
                                    ? AppColors.backGround
                                    : AppColors.selectedText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              CustomSearchField(hint: 'البحث', prefixIcon: Icon(Icons.search)),
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: 'البحث',
              //     prefixIcon: Icon(Icons.search, color: AppColors.primary),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16.r),
              //       borderSide: BorderSide(color: AppColors.primary),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16.r),
              //       borderSide: BorderSide(color: AppColors.primary),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16.r),
              //       borderSide: BorderSide(color: AppColors.primary),
              //     ),
              //   ),
              // ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Container(
                        width: size.width,
                        height: 175.h,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 35.w,
                            right: 30.w,
                            top: 16.h,
                            bottom: 8.h,
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 40.r,
                                    backgroundColor: AppColors.primary,
                                    backgroundImage: AssetImage(
                                      'assets/images/doc.jpg',
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'د. محمد على',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textLabel,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'أخصائي قلب',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    '4.5 ⭐',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.selectedText,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
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
                                      fontSize: 14.sp,
                                      color: AppColors.selectedText,
                                    ),
                                  ),
                                  SizedBox(width: 46.w),
                                  Container(
                                    width: 80.w,
                                    height: 28.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.selectedDoctor
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'متوفر الان',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.selectedDoctor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              CustomButton(
                                text: 'احجز الآن',
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.doctorDetailsScreen,
                                  );
                                },
                                height: 32.h,
                                width: 311.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
