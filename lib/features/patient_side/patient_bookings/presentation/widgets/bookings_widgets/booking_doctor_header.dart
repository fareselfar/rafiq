import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_side/patient_bookings/domain/entities/bookings_entity.dart';
import 'booking_status_badge.dart';

class BookingDoctorHeader extends StatelessWidget {
  final BookingEntity booking;
  const BookingDoctorHeader({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: Image.asset(
            'assets/images/doctor_image_profile.png',
            width: 69.r,
            height: 68.r,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => CircleAvatar(
              radius: 28.r,
              backgroundColor: const Color(0xFFE8F1FF),
              child: Icon(
                Icons.person,
                color: const Color(0xFF468EEC),
                size: 30.sp,
              ),
            ),
          ),
        ),
        WidthSpace(16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.doctor.name,
                style: AppTypography.profileNameStyle.copyWith(fontSize: 14.sp),
              ),
              HeightSpace(8),
              Text(
                booking.doctor.specialization,
                style: AppTypography.profileServiceNameStyle.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        BookingStatusBadge(status: booking.status),
      ],
    );
  }
}
