// domain/repositories/bookings_repository.dart
import 'package:dartz/dartz.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/bookings_entity.dart';

abstract class BookingsRepo {
  Future<Either<String, List<BookingEntity>>> getBookings();
  Future<Either<String, BookingEntity>> getBookingDetails(String id);
  Future<Either<String, Unit>> cancelBooking(String id);
  Future<Either<String, Unit>> rescheduleBooking({
    required String id,
    required DateTime newDate,
    required String newTime,
  });
}

