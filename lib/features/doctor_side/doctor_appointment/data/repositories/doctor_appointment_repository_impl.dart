import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/exceptions.dart';
import 'package:rafiq/core/errors/failure.dart';
import '../../data/datasources/doctor_appointments_datasource.dart';
import '../../domain/entities/doctor_appointments_entity.dart';
import '../../domain/repositories/doctor_appointments_repository.dart';

class DoctorAppointmentsRepositoryImpl implements DoctorAppointmentsRepository {
  final DoctorAppointmentsDatasource remoteDataSource;

  DoctorAppointmentsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, WeeklyScheduleEntity>> getWeeklySchedule({
    required String doctorId,
    required DateTime weekStart,
  }) async {
    try {
      final result = await remoteDataSource.getWeeklySchedule(
        doctorId: doctorId,
        weekStart: weekStart,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return const Left(UnknownFailure(message: 'حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelFullDay({
    required String doctorId,
    required DateTime day,
  }) async {
    try {
      await remoteDataSource.cancelFullDay(doctorId: doctorId, day: day);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return const Left(UnknownFailure(message: 'حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, AppointmentSlotEntity>> editSlot({
    required String slotId,
    required DateTime newDateTime,
    required int newDurationMinutes,
  }) async {
    try {
      final result = await remoteDataSource.editSlot(
        slotId: slotId,
        newDateTime: newDateTime,
        newDurationMinutes: newDurationMinutes,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return const Left(UnknownFailure(message: 'حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelSlot({required String slotId}) async {
    try {
      await remoteDataSource.cancelSlot(slotId: slotId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return const Left(UnknownFailure(message: 'حدث خطأ غير متوقع'));
    }
  }
}