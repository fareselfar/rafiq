import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class UserTypeCard extends StatelessWidget {
  final String iconCaracterPath;
  final String description;
  final String startAs;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unSelectedColor;
  final Color borderColor;

  const UserTypeCard({
    super.key,
    required this.iconCaracterPath,

    required this.description,
    required this.startAs,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.unSelectedColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          top: 40.r,
          right: 25.r,
          bottom: 40.r,
          left: 22.r,
        ),
        width: 161.w,
        height: 339.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.surface,
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: (isSelected
                    ? selectedColor.withValues(alpha: 0.1)
                    : unSelectedColor.withValues(alpha: 0.1)),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: SvgPicture.asset(
                iconCaracterPath,
                width: 32.w,
                height: 32.h,
                color: isSelected ? selectedColor : unSelectedColor,
              ),
            ),

            HeightSpace(13),

            Text(
              description,
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            HeightSpace(65),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  startAs,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySmall.copyWith(
                    color: isSelected ? selectedColor : unSelectedColor,
                  ),
                ),
                WidthSpace(8),
                SvgPicture.asset(
                  'assets/icons/arrow_back.svg',
                  width: 14.w,
                  height: 14.h,
                  color: isSelected ? selectedColor : unSelectedColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
