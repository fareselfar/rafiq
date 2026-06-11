import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/features/patient_side/patient_bookings/domain/entities/bookings_entity.dart';
import 'package:rafiq/features/patient_side/patient_bookings/presentation/widgets/bookings_widgets/booking_status_badge.dart';

class BookingStatus extends StatelessWidget {
  final BookingEntity booking;
  const BookingStatus({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'حالة الحجز',
          style: AppTypography.inputLabel.copyWith(fontWeight: FontWeight.bold),
        ),
        BookingStatusBadge(status: booking.status),
      ],
    );
  }
}
