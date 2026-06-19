// features/patient_bookings/domain/entities/booking_args.dart
class BookingArgs {
  final int doctorId;
  final String doctorName;
  final String specialization;
  final String? imagePath;
  final double? price;
  final String? address;
  final double rate;
  final int reviewsCount;

  const BookingArgs({
    required this.doctorId,
    required this.doctorName,
    required this.specialization,
    this.imagePath,
    this.price,
    this.address,
    this.rate = 0,
    this.reviewsCount = 0,
  });
}