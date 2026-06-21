// features/patient_bookings/data/datasources/booking_remote_datasource.dart
import 'package:dio/dio.dart';
import '../models/slot_model.dart';
import '../models/patient_appointment_model.dart';

abstract class BookingRemoteDatasource {
  Future<List<SlotModel>> getAvailableSlots(int doctorId, DateTime date);
  Future<int> bookAppointment(int doctorId, int slotId);
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

    print('DoctorId = $doctorId');
    print('Date = $dateStr');

    final response = await dio.get(
      '/Doctors/$doctorId/available-slots',
      queryParameters: {'date': dateStr},
    );

    print('Status = ${response.statusCode}');
    print('Response = ${response.data}');

    return (response.data as List).map((e) => SlotModel.fromJson(e)).toList();
  }

  @override
  Future<int> bookAppointment(int doctorId, int slotId) async {
    final response = await dio.post(
      '/Doctors/book',
      data: {'doctorId': doctorId, 'slotId': slotId},
    );
    // الباك بيرجع appointmentId في الـ response
    return response.data['id'] ?? response.data ?? 0;
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
