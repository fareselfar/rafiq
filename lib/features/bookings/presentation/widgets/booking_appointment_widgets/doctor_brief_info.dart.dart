import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/bookings/domain/entities/bookings_entity.dart';

class DoctorBriefInfo extends StatelessWidget {
  final BookingEntity booking;

  const DoctorBriefInfo({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final doctor = booking.doctor; 

    return Column(
      children: [
        CircleAvatar(
          radius: 55.r,
          backgroundImage: doctor.imageUrl.startsWith('http')
              ? NetworkImage(doctor.imageUrl)
              : AssetImage(doctor.imageUrl) as ImageProvider,
        ),
        HeightSpace(8.h),

        Text(
          doctor.name,
          style: AppTypography.doctorName,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        HeightSpace(5.h),
        Text(
          doctor.specialization,
          style: AppTypography.bodymid.copyWith(color: AppColors.primary),
          textAlign: TextAlign.center,
        ),
        HeightSpace(8.h),

        Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            '⭐ ${doctor.rating} (${doctor.reviewCount} مراجعة)',
            style: AppTypography.bodymid.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        HeightSpace(8.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18.sp,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      doctor.address,
                      style: AppTypography.bodymid.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              HeightSpace(8.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'سعر الكشف : ',
                    style: AppTypography.bodymid.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '${doctor.consultationPrice} جنيه',
                      style: AppTypography.bodymid.copyWith(
                        color: AppColors.primary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
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
