import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/date_utils.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/data/models/appointment_details_model.dart';

class PaymentDoctorCard extends StatelessWidget {
  final AppointmentDetailsModel booking;
  final DateTime date;
  final String time;

  const PaymentDoctorCard({
    super.key,
    required this.booking,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
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
              ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: booking.imagePath!.startsWith('http')
                    ? Image.network(
                        booking.imagePath!,
                        width: 70.r,
                        height: 70.r,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            CircleAvatar(
                              radius: 35.r,
                              backgroundColor: const Color(0xFFE8F1FF),
                              child: Icon(
                                Icons.person,
                                color: AppColors.primary,
                                size: 28.sp,
                              ),
                            ),
                      )
                    : Image.asset(
                        booking.imagePath!,
                        width: 70.r,
                        height: 70.r,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            CircleAvatar(
                              radius: 35.r,
                              backgroundColor: const Color(0xFFE8F1FF),
                              child: Icon(
                                Icons.person,
                                color: AppColors.primary,
                                size: 28.sp,
                              ),
                            ),
                      ),
              ),

              const WidthSpace(16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.doctorName,
                      style: AppTypography.doctorName.copyWith(fontSize: 15.sp),
                    ),
                    const HeightSpace(6),
                    Text(
                      booking.specialization,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time, size: 18.sp, color: AppColors.primary),
              const WidthSpace(4),
              Flexible(
                child: Text(
                  time,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodymid.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const WidthSpace(20),
              Icon(
                Icons.calendar_today_outlined,
                size: 18.sp,
                color: AppColors.primary,
              ),
              const WidthSpace(4),
              Flexible(
                child: Text(
                  formatDate(date),
                  maxLines: 1,
                  style: AppTypography.bodymid.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
