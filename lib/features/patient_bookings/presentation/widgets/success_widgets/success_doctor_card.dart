import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/booking_result_args.dart';

class SuccessDoctorCard extends StatelessWidget {
  final BookingResultArgs args;

  const SuccessDoctorCard({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final hasImage = args.imagePath != null && args.imagePath!.isNotEmpty;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.25),
            blurRadius: 10.r,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 35.r,
                backgroundColor: const Color(0xFFE8F1FF),
                backgroundImage: hasImage ? NetworkImage(args.imagePath!) : null,
                onBackgroundImageError: hasImage ? (_, __) {} : null,
                child: !hasImage
                    ? Icon(Icons.person, size:0.8, color: const Color(0xFF90CAF9))
                    : null,
              ),
              const WidthSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      args.doctorName,
                      style: AppTypography.doctorName.copyWith(fontSize: 15.sp),
                    ),
                    const HeightSpace(6),
                    Text(
                      args.specialization,
                      style: AppTypography.bodymid.copyWith(
                        color: AppColors.primary,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F9F1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'استشارة',
                  style: TextStyle(
                    color: const Color(0xFF00CC99),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const HeightSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 18.sp, color: AppColors.warning),
              const WidthSpace(4),
              Text(
                '${args.rate.toStringAsFixed(1)} (${args.reviewsCount} مراجعة)',
                style: AppTypography.bodymid.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}