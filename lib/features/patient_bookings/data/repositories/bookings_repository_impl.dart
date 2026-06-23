// features/patient_bookings/data/repositories/booking_repository_impl.dart
import 'package:rafiq/core/errors/exceptions.dart';
import 'package:rafiq/features/patient_bookings/data/datasources/bookings_remote_datasource.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/patient_booking_entities.dart';
import 'package:rafiq/features/patient_bookings/domain/repositories/bookings_repository.dart';

import '../../domain/entities/slot_entity.dart';
class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDatasource datasource;
  BookingRepositoryImpl(this.datasource);

  @override
  Future<List<SlotEntity>> getAvailableSlots(int doctorId, DateTime date) async {
    final models = await datasource.getAvailableSlots(doctorId, date);
    return models.map((m) => SlotEntity(
      id: m.id,
      time: m.time,
      isReserved: m.isReserved,
    )).toList();
  }

  @override
Future<bool> bookAppointment(int doctorId, int slotId) async {
  try {
    return await datasource.bookAppointment(doctorId, slotId);
  } catch (e) {
    throw ServerException(message: 'Failed to book appointment: ${e.toString()}');
  }
}
  @override
  Future<List<PatientAppointmentEntity>> getMyAppointments({String? status}) async {
    final models = await datasource.getMyAppointments(status: status);
    return models.map((m) => PatientAppointmentEntity(
      id: m.id,
      doctorName: m.doctorName,
      specialization: m.specialization,
      imagePath: m.imagePath,
      appointmentDate: m.appointmentDate,
      appointmentTime: m.appointmentTime,
      location: m.location,
      price: m.price,
      status: m.status,
    )).toList();
  }

  @override
  Future<bool> cancelAppointment(int id) => datasource.cancelAppointment(id);

  @override
  Future<bool> rescheduleAppointment(int id, int slotId) =>
      datasource.rescheduleAppointment(id, slotId);
}