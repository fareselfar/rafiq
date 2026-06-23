// features/patient_bookings/data/datasources/booking_remote_datasource.dart

import 'package:dio/dio.dart';
import '../models/slot_model.dart';
import '../models/patient_appointment_model.dart';

abstract class BookingRemoteDatasource {
  Future<List<SlotModel>> getAvailableSlots(int doctorId, DateTime date);
  Future<bool> bookAppointment(int doctorId, int slotId);
  Future<List<PatientAppointmentModel>> getMyAppointments({String? status});
  Future<bool> cancelAppointment(int appointmentId);
  Future<bool> rescheduleAppointment(int appointmentId, int slotId);
}

class BookingRemoteDatasourceImpl implements BookingRemoteDatasource {
  final Dio dio;
  BookingRemoteDatasourceImpl(this.dio);

  @override
  Future<List<SlotModel>> getAvailableSlots(int doctorId, DateTime date) async {
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    print('🔍 getAvailableSlots → DoctorId=$doctorId, Date=$dateStr');

    final response = await dio.get(
      '/Doctors/$doctorId/available-slots',
      queryParameters: {'date': dateStr},
    );

    print('✅ Slots response: ${response.data}');

    final slots = (response.data as List)
        .map((e) => SlotModel.fromJson(e))
        .toList();

    slots.sort((a, b) => a.rawMinutes.compareTo(b.rawMinutes));

    return slots;
  }

  @override
  Future<bool> bookAppointment(int doctorId, int slotId) async {
    final response = await dio.post(
      '/Doctors/book',
      data: {
        'doctorId': doctorId, 
        'slotId': slotId,
      },
    );

    if (response.data is bool) {
      return response.data as bool;
    }
    return response.statusCode == 200;
  }

  @override
  Future<List<PatientAppointmentModel>> getMyAppointments({
    String? status,
  }) async {
    final response = await dio.get(
      '/Appointments/patient-bookings',
      queryParameters: status != null ? {'status': status} : null,
    );
    return (response.data as List)
        .map((e) => PatientAppointmentModel.fromJson(e))
        .toList();
  }

  @override
  Future<bool> cancelAppointment(int appointmentId) async {
    await dio.put('/Appointments/cancel/$appointmentId');
    return true;
  }

  @override
  Future<bool> rescheduleAppointment(int appointmentId, int slotId) async {
    await dio.put(
      '/Appointments/Update-book',
      data: {'appointmentId': appointmentId, 'slotId': slotId},
    );
    return true;
  }
}
