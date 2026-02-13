import 'package:dartz/dartz.dart';
import 'package:rafiq/features/bookings/domain/repositories/bookings_repository.dart';

class CancelBookingUseCase {
  final BookingsRepo repository;
  CancelBookingUseCase(this.repository);

  Future<Either<String, Unit>> call(String id) async {
    return await repository.cancelBooking(id);
  }
}


