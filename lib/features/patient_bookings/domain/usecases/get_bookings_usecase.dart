import 'package:dartz/dartz.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/bookings_entity.dart';
import 'package:rafiq/features/patient_bookings/domain/repositories/bookings_repository.dart';

class GetBookingsUseCase {
  final BookingsRepo repository;
  GetBookingsUseCase(this.repository);

  Future<Either<String, List<BookingEntity>>> call() async {
    return await repository.getBookings();
  }
}

