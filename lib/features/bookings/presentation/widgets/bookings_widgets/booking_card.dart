import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/enums/booking__status.dart';
import 'package:rafiq/features/bookings/domain/entities/bookings_entity.dart';
import 'booking_doctor_header.dart';
import 'booking_info_section.dart';
import 'booking_action_buttons.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;
  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 23.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF468EEC).withOpacity(0.25),
            blurRadius: 4.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookingDoctorHeader(booking: booking),
          HeightSpace(8),
          if (booking.status != BookingStatus.cancelled) ...[
            BookingInfoSection(booking: booking),
            HeightSpace(8),
            BookingActionButtons(booking: booking),
          ],
        ],
      ),
    );
  }
}
