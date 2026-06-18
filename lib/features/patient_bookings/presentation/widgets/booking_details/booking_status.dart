import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/enums/booking__status.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/patient_booking_entities.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/bookings_widgets/booking_status_badge.dart';

class BookingStatusWidget extends StatelessWidget {
  final AppointmentDetailsEntity details;
  const BookingStatusWidget({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'حالة الحجز',
          style: AppTypography.inputLabel.copyWith(fontWeight: FontWeight.bold),
        ),
        BookingStatusBadge(status: details.status.toBookingStatus()),
      ],
    );
  }
}