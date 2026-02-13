import 'package:dartz/dartz.dart';
import 'package:rafiq/features/bookings/data/datasources/mock_bookings_service.dart' ;
import 'package:rafiq/features/bookings/domain/entities/bookings_entity.dart';
import 'package:rafiq/features/bookings/domain/repositories/bookings_repository.dart';

class MockBookingsRepository implements BookingsRepo { // تأكد من اسم الـ Interface عندك
  @override
  Future<Either<String, List<BookingEntity>>> getBookings() async {
    try {
      return Right(MockBookingsService.dummyBookings);
    } catch (e) {
      return const Left("فشل في جلب الحجوزات");
    }
  }

  @override
  Future<Either<String, BookingEntity>> getBookingDetails(String id) async {
    try {
      final booking = MockBookingsService.dummyBookings.firstWhere((b) => b.id == id);
      return Right(booking);
    } catch (e) {
      return const Left("الحجز غير موجود");
    }
  }

  @override
  Future<Either<String, Unit>> cancelBooking(String id) async {
    return const Right(unit);
  }

  @override
  Future<Either<String, Unit>> rescheduleBooking({
    required String id,
    required DateTime newDate,
    required String newTime,
  }) async {
    return const Right(unit);
  }
}