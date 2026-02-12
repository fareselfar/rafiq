import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

class SmallCard extends StatelessWidget {
  const SmallCard({
    super.key,
    required this.title,
    required,
    required this.hightPadding,
    required this.widthPadding,
    required this.onTap,
    this.selectedBgcolor,
    this.selectedFgcolor,
    this.unSelectedBgcolor,
    this.unSelectedFgcolor,
  });
  final String title;
  final double widthPadding;
  final double hightPadding;
  final VoidCallback onTap;
  final Color? selectedBgcolor;
  final Color? unSelectedBgcolor;
  final Color? selectedFgcolor;
  final Color? unSelectedFgcolor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: widthPadding,
            vertical: hightPadding,
          ),
          child: Text(title, style: AppTypography.button),
        ),
      ),
    );
  }
}
