// lib/features/doctor_side/doctor_home/presentation/widgets/doctor_home_top_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';


class DoctorHomeTopBar extends StatelessWidget {
  final String doctorName;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;

  const DoctorHomeTopBar({
    super.key,
    required this.doctorName,
    this.onNotificationTap,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DoctorNameAvatarRow(
            doctorName: doctorName,
            onAvatarTap: onAvatarTap,
          ),
          DoctorNotificationBell(onTap: onNotificationTap),
        ],
      ),
    );
  }
}

class DoctorNotificationBell extends StatelessWidget {
  final VoidCallback? onTap;

  const DoctorNotificationBell({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 28.w,
        height: 28.h,
        child: Icon(
          Icons.notifications_none_rounded,
          color: AppColors.textSecondary,
          size: 24.sp,
        ),
      ),
    );
  }
}

class DoctorNameAvatarRow extends StatelessWidget {
  final String doctorName;
  final VoidCallback? onAvatarTap;

  const DoctorNameAvatarRow({
    super.key,
    required this.doctorName,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DoctorTopBarAvatar(onTap: onAvatarTap),
        const WidthSpace(8),
        DoctorTopBarName(name: doctorName),
      ],
    );
  }
}

class DoctorTopBarName extends StatelessWidget {
  final String name;

  const DoctorTopBarName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: AppTypography.bodymid.copyWith(
        color: AppColors.selectedText,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class DoctorTopBarAvatar extends StatelessWidget {
  final VoidCallback? onTap;

  const DoctorTopBarAvatar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.h,
        decoration: const BoxDecoration(
          color: Color(0xFFDBEAFE),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person_outline_rounded,
          color: AppColors.primary,
          size: 26.sp,
        ),
      ),
    );
  }
}