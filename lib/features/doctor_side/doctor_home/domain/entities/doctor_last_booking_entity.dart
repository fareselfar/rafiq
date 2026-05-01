import 'doctor_appointment_status.dart';

class DoctorLastBookingEntity {
  final String id;
  final String patientName;
  final String patientAvatarUrl;
  final String date;
  final String time;
  final DoctorAppointmentStatus status;

  const DoctorLastBookingEntity({
    required this.id,
    required this.patientName,
    required this.patientAvatarUrl,
    required this.date,
    required this.time,
    required this.status,
  });
}