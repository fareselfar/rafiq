import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

class DoctorAvailabilitySection extends StatelessWidget {
  final String address;
  final bool isAvailable;

  const DoctorAvailabilitySection({
    super.key,
    required this.address,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: DoctorLocation(address: address)),
        SizedBox(width: 10.w),
        DoctorStatusBadge(isAvailable: isAvailable),
      ],
    );
  }
}

class DoctorLocation extends StatelessWidget {
  final String address;

  const DoctorLocation({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: AppColors.textSecondary,
          size: 18.sp,
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            address,
            style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class DoctorStatusBadge extends StatelessWidget {
  final bool isAvailable;

  const DoctorStatusBadge({super.key, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isAvailable ? const Color(0xFFE2F9F0) : const Color(0xFFFFF1E6),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        isAvailable ? 'متوفر الآن' : 'متاح غداً',
        style: TextStyle(
          color: isAvailable ? const Color(0xFF1ABC9C) : const Color(0xFFE67E22),
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}