import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';

class CancelDayButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const CancelDayButton({super.key, this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'إلغاء يوم كامل',
      onPressed: onPressed,
      type: ButtonType.outlined,
      isLoading: isLoading,
      width: double.infinity,
      borderColor: AppColors.error,
      borderRadius: 10,
      textStyle: TextStyle(
        color: AppColors.error,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
