import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_appointment_status.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_today_appointment_entity.dart';

class DoctorTodayAppointmentModel extends DoctorTodayAppointmentEntity {
  const DoctorTodayAppointmentModel({
    required super.id,
    required super.patientName,
    required super.patientAvatarUrl,
    required super.time,
    required super.isNewPatient,
    required super.status,
  });

  factory DoctorTodayAppointmentModel.fromJson(Map<String, dynamic> json) =>
      DoctorTodayAppointmentModel(
        id: json['id'] as String,
        patientName: json['patient_name'] as String,
        patientAvatarUrl: json['patient_avatar_url'] as String? ?? '',
        time: json['time'] as String,
        isNewPatient: json['is_new_patient'] as bool? ?? false,
        status: DoctorAppointmentStatus.fromString(json['status'] as String?),
      );
}
