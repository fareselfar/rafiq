import 'package:rafiq/features/patient_bookings/domain/repositories/patient_bookings_repository.dart';

import '../datasources/patient_bookings_datasource.dart';
import '../../domain/entities/patient_booking_entities.dart';

class PatientBookingsRepositoryImpl implements PatientBookingsRepository {
  final PatientBookingsDatasource datasource;
  PatientBookingsRepositoryImpl(this.datasource);

  @override
  Future<List<PatientAppointmentEntity>> getMyAppointments({
    String? status,
  }) async {
    final models = await datasource.getMyAppointments(status: status);
    return models
        .map(
          (m) => PatientAppointmentEntity(
            id: m.id,
            doctorName: m.doctorName,
            specialization: m.specialization,
            imagePath: m.imagePath,
            appointmentDate: m.appointmentDate,
            appointmentTime: m.appointmentTime,
            location: m.location,
            price: m.price,
            status: m.status,
          ),
        )
        .toList();
  }

  @override
  Future<AppointmentDetailsEntity> getAppointmentDetails(
    int appointmentId,
  ) async {
    final m = await datasource.getAppointmentDetails(appointmentId);
    return AppointmentDetailsEntity(
      id: m.id,
      doctorId: m.doctorId,
      doctorName: m.doctorName,
      specialization: m.specialization,
      imagePath: m.imagePath,
      rate: m.rate,
      reviewsCount: m.reviewsCount,
      dayName: m.dayName,
      date: m.date,
      time: m.time,
      location: m.location,
      consultationPrice: m.consultationPrice ?? 0,
      discount: m.discount ?? 0,
      totalAmount: m.totalAmount ?? 0,
      status: m.status,
    );
  }

  @override
  Future<void> cancelAppointment(int appointmentId) =>
      datasource.cancelAppointment(appointmentId);

  @override
  Future<void> rescheduleAppointment(int appointmentId, int slotId) =>
      datasource.rescheduleAppointment(appointmentId, slotId);
}
