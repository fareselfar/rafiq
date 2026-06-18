import 'package:rafiq/features/patient_bookings/domain/entities/patient_booking_entities.dart';

abstract class PatientBookingsRepository {
  Future<List<PatientAppointmentEntity>> getMyAppointments({String? status});
  Future<AppointmentDetailsEntity> getAppointmentDetails(int appointmentId);
  Future<void> cancelAppointment(int appointmentId);
  Future<void> rescheduleAppointment(int appointmentId, int slotId);
}