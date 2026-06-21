import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/enums/booking__status.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/patient_booking_entities.dart';
import 'booking_status_badge.dart';

class BookingDoctorHeader extends StatelessWidget {
  final PatientAppointmentEntity booking;
  const BookingDoctorHeader({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: booking.imagePath != null && booking.imagePath!.isNotEmpty
              ? Image.network(
                  booking.imagePath!,
                  width: 69.r,
                  height: 68.r,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                )
              : _buildPlaceholder(),
        ),
        WidthSpace(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.doctorName,
                style: AppTypography.profileNameStyle.copyWith(fontSize: 14.sp),
              ),
              HeightSpace(8),
              Text(
                booking.specialization,
                style: AppTypography.profileServiceNameStyle.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        BookingStatusBadge(status: booking.status.toBookingStatus()),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return CircleAvatar(
      radius: 34.r,
      backgroundColor: const Color(0xFFE8F1FF),
      child: Icon(
        Icons.person,
        color: const Color(0xFF468EEC),
        size: 30.sp,
      ),
    );
  }
}