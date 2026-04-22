import 'package:dartz/dartz.dart';
import 'package:rafiq/features/patient_bookings/data/datasources/bookings_remote_datasource.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/bookings_entity.dart';
import 'package:rafiq/features/patient_bookings/domain/repositories/bookings_repository.dart';

class BookingsRepositoryImpl implements BookingsRepo {
  final BookingsRemoteDataSource remoteDataSource;

  BookingsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<BookingEntity>>> getBookings() async {
    try {
      final remoteData = await remoteDataSource.getBookings();
      return Right(remoteData);
    } catch (e) {
      return Left("عذراً، تعذر جلب الحجوزات حالياً");
    }
  }

  @override
  Future<Either<String, BookingEntity>> getBookingDetails(String id) async {
    try {
      final bookings = await remoteDataSource.getBookings();
      final booking = bookings.firstWhere((b) => b.id == id);
      return Right(booking);
    } catch (e) {
      return Left("تعذر جلب تفاصيل الحجز");
    }
  }

  @override
  Future<Either<String, Unit>> cancelBooking(String id) async {
    try {
      await remoteDataSource.cancelBooking(id);
      return const Right(unit);
    } catch (e) {
      return Left("فشل إلغاء الحجز، حاول مرة أخرى");
    }
  }

  @override
  Future<Either<String, Unit>> rescheduleBooking({
    required String id,
    required DateTime newDate,
    required String newTime,
  }) async {
    try {
      final dateStr =
          "${newDate.year}-${newDate.month}-${newDate.day}";
      await remoteDataSource.rescheduleBooking(id, dateStr, newTime);
      return const Right(unit);
    } catch (e) {
      return Left("فشل في تحديث موعد الحجز");
    }
  }
}
