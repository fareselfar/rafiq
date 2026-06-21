// lib/features/doctor_side/doctor_appointments/data/repositories/doctor_appointments_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:flutter/src/material/time.dart';
import 'package:rafiq/core/errors/exceptions.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/data/datasources/doctor_appointments_datasource.dart';
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
        weekStart: weekStart,
      );
      return Right(result);
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message, code: e.statusCode));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelFullDay({
    required String doctorId,
    required DateTime day,
  }) async {
    try {
      await remoteDataSource.cancelFullDay(day: day);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
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
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppointmentSlotEntity>> editSlot({
    required String slotId,
    required DateTime newDateTime,
    required int newDurationMinutes,
  }) async {
    try {
      final h = newDateTime.hour.toString().padLeft(2, '0');
      final m = newDateTime.minute.toString().padLeft(2, '0');
      await remoteDataSource.editSlot(slotId: slotId, newFromTime: '$h:$m:00');
      // نرجع نفس الـ slot بالوقت الجديد
      return Right(
        AppointmentSlotEntity(
          id: slotId,
          dateTime: newDateTime,
          durationMinutes: newDurationMinutes,
          status: DoctorAppointmentStatus.confirmed,
          visitType: 'كشف',
          isBooked: false,
        ),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addAvailability({
    required DateTime date,
    required TimeOfDay from,
    required TimeOfDay to,
  }) async {
    try {
      await remoteDataSource.addAvailability(date: date, from: from, to: to);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
