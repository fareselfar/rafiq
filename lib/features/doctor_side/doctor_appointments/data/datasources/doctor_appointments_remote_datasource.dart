import '../models/doctor_appointments_model.dart';

abstract class DoctorAppointmentsRemoteDataSource {
  Future<List<DoctorAppointmentsModel>> getDoctorAppointmentss();
  Future<DoctorAppointmentsModel> getDoctorAppointmentsById(String id);
}

class DoctorAppointmentsRemoteDataSourceImpl
    implements DoctorAppointmentsRemoteDataSource {
  @override
  Future<List<DoctorAppointmentsModel>> getDoctorAppointmentss() async {
    throw UnimplementedError();
  }

  @override
  Future<DoctorAppointmentsModel> getDoctorAppointmentsById(String id) async {
    throw UnimplementedError();
  }
}
