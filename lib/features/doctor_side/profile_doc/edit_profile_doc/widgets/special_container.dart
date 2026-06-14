import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_fonts.dart';

class SpecialContainer extends StatelessWidget {
  const SpecialContainer({
    super.key,
    this.bgColor,
    this.title,
    this.titleColor,
  });
  final Color? bgColor;
  final String? title;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.lightBlue,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Text(
          title ?? "مستخدم",
          style: TextStyle(
            fontFamily: AppFonts.mainFontName,
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: titleColor ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}
