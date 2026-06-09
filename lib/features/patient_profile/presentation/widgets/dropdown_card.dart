import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

class DropdownCard extends StatelessWidget {
  const DropdownCard({
    super.key,
    this.title,
    required this.width,
    required this.customDropdownOptions,
  });
  final String? title;
  final double width;
  final Widget customDropdownOptions;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.hintStyle, width: 2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(title ?? '', style: AppTypography.inputHint),
            Spacer(),
            customDropdownOptions,
          ],
        ),
      ),
    );
  }
}
