import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_appointment_status.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_last_booking_entity.dart';

class DoctorLastBookingModel extends DoctorLastBookingEntity {
  const DoctorLastBookingModel({
    required super.id,
    required super.patientName,
    required super.patientAvatarUrl,
    required super.date,
    required super.time,
    required super.status,
  });

  factory DoctorLastBookingModel.fromJson(Map<String, dynamic> json) {
    return DoctorLastBookingModel(
      id: json['id'] as String? ?? '',
      patientName: json['patient_name'] as String? ?? '',
      patientAvatarUrl: json['patient_avatar_url'] as String? ?? '',
      date: json['date'] as String? ?? '',
      time: json['time'] as String? ?? '',
      // الحل الصح هنا: تنادي الـ Enum مباشرة
      status: DoctorAppointmentStatus.fromString(json['status'] as String?),
    );
  }
}
