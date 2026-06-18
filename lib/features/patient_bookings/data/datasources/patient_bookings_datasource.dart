import 'package:dio/dio.dart';
import '../models/patient_appointment_model.dart';
import '../models/appointment_details_model.dart';

abstract class PatientBookingsDatasource {
  Future<List<PatientAppointmentModel>> getMyAppointments({String? status});
  Future<AppointmentDetailsModel> getAppointmentDetails(int appointmentId);
  Future<void> cancelAppointment(int appointmentId);
  Future<void> rescheduleAppointment(int appointmentId, int slotId);
}

class PatientBookingsDatasourceImpl implements PatientBookingsDatasource {
  final Dio dio;
  PatientBookingsDatasourceImpl(this.dio);

  @override
  Future<List<PatientAppointmentModel>> getMyAppointments({String? status}) async {
    final response = await dio.get(
      '/api/Appointments/patient-bookings',
      queryParameters: status != null ? {'status': status} : null,
    );
    return (response.data as List)
        .map((e) => PatientAppointmentModel.fromJson(e))
        .toList();
  }

  @override
  Future<AppointmentDetailsModel> getAppointmentDetails(int appointmentId) async {
    final response = await dio.get('/api/Appointments/details/$appointmentId');
    return AppointmentDetailsModel.fromJson(response.data);
  }

  @override
  Future<void> cancelAppointment(int appointmentId) async {
    await dio.put('/api/Appointments/$appointmentId/cancel');
  }

  @override
  Future<void> rescheduleAppointment(int appointmentId, int slotId) async {
    await dio.put(
      '/api/Appointments/Update-book',
      data: {'appointmentId': appointmentId, 'slotId': slotId},
    );
  }
}