import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';

class SmallCard extends StatelessWidget {
  const SmallCard({
    super.key,
    required this.title,
    required,
    required this.hightPadding,
    required this.widthPadding,
    required this.onTap,
    this.bgColor,
    this.fgColor,
    this.textStyle,
    required this.isList,
  });
  final String title;
  final double widthPadding;
  final double hightPadding;
  final VoidCallback onTap;
  final Color? bgColor;
  final TextStyle? textStyle;
  final Color? fgColor;
  final bool isList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.primary,

          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: widthPadding,
            vertical: hightPadding,
          ),
          child: Text(
            title,
            style: isList
                ? GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: fgColor ?? AppColors.surface,
                  )
                : GoogleFonts.cairo(
                    fontSize: 10.sp,
                    color: fgColor ?? AppColors.surface,
                    fontWeight: FontWeight.w600,
                  ),
          ),
        ),
      ),
    );
  }
}
