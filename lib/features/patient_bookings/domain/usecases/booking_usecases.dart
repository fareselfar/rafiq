// features/patient_bookings/domain/usecases/booking_usecases.dart
import 'package:rafiq/features/patient_bookings/domain/entities/patient_booking_entities.dart';
import 'package:rafiq/features/patient_bookings/domain/repositories/bookings_repository.dart';

import '../entities/slot_entity.dart';

class GetAvailableSlotsUseCase {
  final BookingRepository repository;
  GetAvailableSlotsUseCase(this.repository);
  Future<List<SlotEntity>> call(int doctorId, DateTime date) =>
      repository.getAvailableSlots(doctorId, date);
}

class BookAppointmentUseCase {
  final BookingRepository repository;
  BookAppointmentUseCase(this.repository);
  Future<bool> call(int doctorId, int slotId) async {
    return await repository.bookAppointment(doctorId, slotId);
  }
}

class GetMyAppointmentsUseCase {
  final BookingRepository repository;
  GetMyAppointmentsUseCase(this.repository);
  Future<List<PatientAppointmentEntity>> call({String? status}) =>
      repository.getMyAppointments(status: status);
}

class CancelAppointmentUseCase {
  final BookingRepository repository;
  CancelAppointmentUseCase(this.repository);
  Future<bool> call(int id) => repository.cancelAppointment(id);
}

class RescheduleAppointmentUseCase {
  final BookingRepository repository;
  RescheduleAppointmentUseCase(this.repository);
  Future<bool> call(int appointmentId, int slotId) =>
      repository.rescheduleAppointment(appointmentId, slotId);
}