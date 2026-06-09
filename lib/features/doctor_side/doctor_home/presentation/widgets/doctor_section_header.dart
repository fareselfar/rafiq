// lib/features/doctor_side/doctor_home/presentation/widgets/doctor_section_header.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

/// Reusable section header.
/// RTL app: Row automatically renders → Title on RIGHT, action on LEFT ✓
/// No textDirection overrides needed.
class DoctorSectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const DoctorSectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // In RTL app: first child = RIGHT side ✓ (section title)
        SectionTitleText(title: title),
        if (trailing != null) trailing!,
      ],
    );
  }
}

/// Section title — bold, no textDirection override
class SectionTitleText extends StatelessWidget {
  final String title;

  const SectionTitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTypography.profileServicesStyle);
  }
}

/// "عرض الكل" link — primary blue
class ViewAllLink extends StatelessWidget {
  final VoidCallback? onTap;

  const ViewAllLink({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Text(
          'عرض الكل',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.primary,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
