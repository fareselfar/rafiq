// lib/features/doctor_side/doctor_appointments/presentation/widgets/week_navigator.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';

class WeekNavigator extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const WeekNavigator({
    super.key,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _WindowNavButton(icon: Icons.arrow_back_ios_new_rounded, onTap: onNext), // التالي (يسار للـ RTL أو يمين حسب اتجاه التطبيق)
          _WindowNavButton(icon: Icons.arrow_forward_ios_rounded, onTap: onPrevious), // السابق
        ],
      ),
    );
  }
}

class _WindowNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _WindowNavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}