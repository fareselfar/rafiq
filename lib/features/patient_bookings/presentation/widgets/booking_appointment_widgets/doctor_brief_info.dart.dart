// lib/features/patient_bookings/presentation/widgets/booking_appointment_widgets/doctor_brief_info.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/bookings_entity.dart';

class DoctorBriefInfo extends StatelessWidget {
  final BookingArgs booking;

  const DoctorBriefInfo({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final hasImage =
        booking.imagePath != null && booking.imagePath!.isNotEmpty;

    return Column(
      children: [
        CircleAvatar(
          radius: 55.r,
          backgroundColor: const Color(0xFFE3F2FD),
          backgroundImage: hasImage ? NetworkImage(booking.imagePath!) : null,
          child: !hasImage
              ? Icon(Icons.person,
                  size: 45.r, color: const Color(0xFF90CAF9))
              : null,
        ),
        HeightSpace(8),
        Text(
          booking.doctorName,
          style: AppTypography.doctorName,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        HeightSpace(5),
        Text(
          booking.specialization,
          style: AppTypography.bodymid.copyWith(color: AppColors.primary),
          textAlign: TextAlign.center,
        ),
        HeightSpace(8),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            '⭐ ${booking.rate.toStringAsFixed(1)} (${booking.reviewsCount} مراجعة)',
            style: AppTypography.bodymid
                .copyWith(color: AppColors.textSecondary),
          ),
        ),
        HeightSpace(8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              if (booking.address != null && booking.address!.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 18.sp, color: AppColors.textSecondary),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        booking.address!,
                        style: AppTypography.bodymid
                            .copyWith(color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              HeightSpace(8),
              if (booking.price != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'سعر الكشف : ',
                      style: AppTypography.bodymid
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    Text(
                      '${booking.price!.toInt()} جنيه',
                      style: AppTypography.bodymid
                          .copyWith(color: AppColors.primary),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}