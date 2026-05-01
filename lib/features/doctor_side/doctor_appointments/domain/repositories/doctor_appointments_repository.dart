import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/doctor_appointments_entity.dart';

abstract class DoctorAppointmentsRepository {
  Future<Either<Failure, List<DoctorAppointmentsEntity>>>
  getDoctorAppointmentss();
  Future<Either<Failure, DoctorAppointmentsEntity>> getDoctorAppointmentsById(
    String id,
  );
}
