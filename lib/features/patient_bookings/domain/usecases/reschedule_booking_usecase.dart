// domain/usecases/reschedule_booking_usecase.dart
import 'package:dartz/dartz.dart';
import '../repositories/bookings_repository.dart'; 

class RescheduleBookingUseCase {
  final BookingsRepo repository; 
  RescheduleBookingUseCase(this.repository);

  Future<Either<String, Unit>> call(RescheduleParams params) async {
    return await repository.rescheduleBooking(
      id: params.id,
      newDate: params.newDate,
      newTime: params.newTime,
    );
  }
}

class RescheduleParams {
  final String id;
  final DateTime newDate;
  final String newTime;
  RescheduleParams({required this.id, required this.newDate, required this.newTime});
}