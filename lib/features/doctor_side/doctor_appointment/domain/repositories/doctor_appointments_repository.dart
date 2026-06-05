// lib/features/doctor_side/doctor_appointments/domain/repositories/doctor_appointments_repository.dart

import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import '../entities/doctor_appointments_entity.dart';

abstract class DoctorAppointmentsRepository {
  /// Get full week schedule starting from [weekStart]
  Future<Either<Failure, WeeklyScheduleEntity>> getWeeklySchedule({
    required String doctorId,
    required DateTime weekStart,
  });

  /// Cancel a full day — sets all slots to cancelled
  Future<Either<Failure, void>> cancelFullDay({
    required String doctorId,
    required DateTime day,
  });

  /// Edit a single slot time/duration
  Future<Either<Failure, AppointmentSlotEntity>> editSlot({
    required String slotId,
    required DateTime newDateTime,
    required int newDurationMinutes,
  });

  /// Cancel a single slot
  Future<Either<Failure, void>> cancelSlot({required String slotId});
}
