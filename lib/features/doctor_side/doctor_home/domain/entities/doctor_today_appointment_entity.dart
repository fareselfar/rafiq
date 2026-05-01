import 'doctor_appointment_status.dart';

class DoctorTodayAppointmentEntity {
  final String id;
  final String patientName;
  final String patientAvatarUrl;
  final String time;
  final bool isNewPatient;
  final DoctorAppointmentStatus status;

  const DoctorTodayAppointmentEntity({
    required this.id,
    required this.patientName,
    required this.patientAvatarUrl,
    required this.time,
    required this.isNewPatient,
    required this.status,
  });
}