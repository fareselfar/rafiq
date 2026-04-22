// domain/usecases/get_booking_details.dart
import 'package:dartz/dartz.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/bookings_entity.dart';
import '../repositories/bookings_repository.dart'; // Import الـ Abstract بس

class GetBookingDetailsUseCase {
  final BookingsRepo repository; // بيكلم الـ Abstract
  GetBookingDetailsUseCase(this.repository);

  Future<Either<String, BookingEntity>> call(String id) async {
    return await repository.getBookingDetails(id);
  }
}


