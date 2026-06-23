// features/patient_bookings/domain/repositories/booking_repository.dart
import 'package:rafiq/features/patient_bookings/domain/entities/patient_booking_entities.dart';

import '../entities/slot_entity.dart';

abstract class BookingRepository {
  Future<List<SlotEntity>> getAvailableSlots(int doctorId, DateTime date);
  Future<bool> bookAppointment(int doctorId, int slotId);
  Future<List<PatientAppointmentEntity>> getMyAppointments({String? status});
  Future<bool> cancelAppointment(int appointmentId);
  Future<bool> rescheduleAppointment(int appointmentId, int slotId);
}
