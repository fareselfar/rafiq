import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/enums/booking__status.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/patient_booking_entities.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/bookings_widgets/booking_status_badge.dart';

class BookingDoctorDetailsCard extends StatelessWidget {
  final AppointmentDetailsEntity details;
  const BookingDoctorDetailsCard({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final hasImage = details.imagePath != null && details.imagePath!.isNotEmpty;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
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
                backgroundImage: hasImage
                    ? NetworkImage(details.imagePath!)
                    : null,
                onBackgroundImageError: hasImage ? (_, _) {} : null,
                child: !hasImage
                    ? Icon(
                        Icons.person,
                        size: 0.8,
                        color: const Color(0xFF90CAF9),
                      )
                    : null,
              ),
              const WidthSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details.doctorName,
                      style: AppTypography.doctorName.copyWith(fontSize: 15.sp),
                    ),
                    const HeightSpace(6),
                    Text(
                      details.specialization,
                      style: AppTypography.bodymid.copyWith(
                        color: AppColors.primary,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              BookingStatusBadge(status: details.status.toBookingStatus()),
            ],
          ),
          const HeightSpace(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 18.sp, color: AppColors.warning),
              const WidthSpace(4),
              Text(
                '${details.rate.toStringAsFixed(1)} (${details.reviewsCount} مراجعة)',
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
