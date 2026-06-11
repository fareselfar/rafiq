import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class SuccessHeader extends StatelessWidget {
  const SuccessHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.check_circle_outline_rounded,
          color: AppColors.primary,
          size: 80.sp,
        ),
        const HeightSpace(24),
        Text(
          "تم تأكيد حجزك بنجاح",
          style: AppTypography.dialogTitle.copyWith(color: AppColors.primary),
        ),
        const HeightSpace(10),
        Text(
          "يمكنك متابعة تفاصيل الموعد من صفحة حجوزاتي",
          textAlign: TextAlign.center,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
