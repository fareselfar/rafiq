import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/patient_booking_entities.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/bookings_widgets/info_item.dart';

class BookingInfoSection extends StatelessWidget {
  final PatientAppointmentEntity booking;
  const BookingInfoSection({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InfoItem(
                icon: Icons.calendar_today,
                text: booking.appointmentDate,
              ),
            ),
            Expanded(
              child: InfoItem(
                icon: Icons.access_time_rounded,
                text: booking.appointmentTime,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InfoItem(
                icon: Icons.location_on_outlined,
                text: booking.location,
              ),
            ),
            Expanded(
              child: InfoItem(
                icon: Icons.account_balance_wallet_outlined,
                text: "${booking.price} جنيه",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
