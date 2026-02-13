import 'package:rafiq/features/bookings/data/datasources/mock_bookings_service.dart' as MockBookingsService;
import 'package:rafiq/features/bookings/domain/entities/bookings_entity.dart';

class GetBookingsMockUseCase {
  Future<List<BookingEntity>> call() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockBookingsService.MockBookingsService.dummyBookings;
  }
}