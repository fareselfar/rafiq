// features/patient_bookings/domain/entities/booking_result_args.dart
class BookingResultArgs {
  final int appointmentId;
  final String doctorName;
  final String specialization;
  final String? imagePath;
  final double rate;
  final int reviewsCount;
  final String date;      
  final String dayName;   
  final String time;      
  final String location;

  const BookingResultArgs({
    required this.appointmentId,
    required this.doctorName,
    required this.specialization,
    this.imagePath,
    required this.rate,
    required this.reviewsCount,
    required this.date,
    required this.dayName,
    required this.time,
    required this.location,
  });
}