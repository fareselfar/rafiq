// lib/features/doctor_side/doctor_appointments/domain/usecases/doctor_appointments_usecases.dart

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rafiq/core/errors/failure.dart';
import '../entities/doctor_appointments_entity.dart';
import '../repositories/doctor_appointments_repository.dart';

class GetWeeklyScheduleUsecase {
  final DoctorAppointmentsRepository repository;
  GetWeeklyScheduleUsecase(this.repository);

  Future<Either<Failure, WeeklyScheduleEntity>> call({
    required String doctorId,
    required DateTime weekStart,
  }) => repository.getWeeklySchedule(doctorId: doctorId, weekStart: weekStart);
}

class CancelFullDayUsecase {
  final DoctorAppointmentsRepository repository;
  CancelFullDayUsecase(this.repository);

  Future<Either<Failure, void>> call({
    required String doctorId,
    required DateTime day,
  }) => repository.cancelFullDay(doctorId: doctorId, day: day);
}

class EditSlotUsecase {
  final DoctorAppointmentsRepository repository;
  EditSlotUsecase(this.repository);

  Future<Either<Failure, AppointmentSlotEntity>> call({
    required String slotId,
    required DateTime newDateTime,
    required int newDurationMinutes,
  }) => repository.editSlot(
        slotId: slotId,
        newDateTime: newDateTime,
        newDurationMinutes: newDurationMinutes,
      );
}

class CancelSlotUsecase {
  final DoctorAppointmentsRepository repository;
  CancelSlotUsecase(this.repository);

  Future<Either<Failure, void>> call({required String slotId}) =>
      repository.cancelSlot(slotId: slotId);
}

class AddAvailabilityUsecase {
  final DoctorAppointmentsRepository repository;
  AddAvailabilityUsecase(this.repository);

  Future<Either<Failure, void>> call({
    required DateTime date,
    required TimeOfDay from,
    required TimeOfDay to,
  }) => repository.addAvailability(date: date, from: from, to: to);
}