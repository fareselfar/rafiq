
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

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
