import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

class DurationSelector extends StatelessWidget {
  final int duration;
  final ValueChanged<int> onChanged;

  const DurationSelector({
    super.key,
    required this.duration,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [15, 30, 45, 60].map((d) {
        final selected = duration == d;

        return GestureDetector(
          onTap: () => onChanged(d),
          child: Container(
            margin: EdgeInsets.only(left: 8.w),
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primary
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: selected
                    ? AppColors.primary
                    : AppColors.border,
              ),
            ),
            child: Text(
              '$d د',
              style: AppTypography.bodySmall.copyWith(
                color: selected
                    ? Colors.white
                    : AppColors.textSecondary,
                fontSize: 12.sp,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}