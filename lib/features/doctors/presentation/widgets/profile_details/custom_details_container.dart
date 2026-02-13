import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class CustomDetailsContainer extends StatelessWidget {
  const CustomDetailsContainer({
    super.key,
    required this.icon, 
    required this.title,
    required this.subTitle,
  });

  final IconData icon; 
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 104.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r), 
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40.sp, 
            color: AppColors.primary, 
          ),
          HeightSpace(8.h),
          Text(
            title,
            style: AppTypography.subTitelStyle.copyWith(
              color: AppColors.primary,
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