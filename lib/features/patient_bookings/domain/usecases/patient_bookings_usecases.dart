import 'package:rafiq/features/patient_bookings/domain/repositories/patient_bookings_repository.dart';

import '../entities/patient_booking_entities.dart';

class GetMyAppointmentsUseCase {
  final PatientBookingsRepository repository;
  GetMyAppointmentsUseCase(this.repository);
  Future<List<PatientAppointmentEntity>> call({String? status}) =>
      repository.getMyAppointments(status: status);
}

class GetAppointmentDetailsUseCase {
  final PatientBookingsRepository repository;
  GetAppointmentDetailsUseCase(this.repository);
  Future<AppointmentDetailsEntity> call(int appointmentId) =>
      repository.getAppointmentDetails(appointmentId);
}

class CancelAppointmentUseCase {
  final PatientBookingsRepository repository;
  CancelAppointmentUseCase(this.repository);
  Future<void> call(int appointmentId) =>
      repository.cancelAppointment(appointmentId);
}

class RescheduleAppointmentUseCase {
  final PatientBookingsRepository repository;
  RescheduleAppointmentUseCase(this.repository);
  Future<void> call(int appointmentId, int slotId) =>
      repository.rescheduleAppointment(appointmentId, slotId);
}