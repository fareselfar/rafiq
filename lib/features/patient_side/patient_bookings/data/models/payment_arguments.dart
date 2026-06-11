import 'package:rafiq/features/patient_side/patient_bookings/domain/entities/bookings_entity.dart';

class PaymentArguments {
  final BookingEntity booking;
  final DateTime date;
  final String time;

  PaymentArguments({
    required this.booking,
    required this.date,
    required this.time,
  });
}
