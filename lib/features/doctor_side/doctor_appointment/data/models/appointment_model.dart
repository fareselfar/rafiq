// lib/features/doctor_side/doctor_appointments/data/models/appointment_model.dart

import '../../domain/entities/doctor_appointments_entity.dart';

/// Maps GET /api/Appointments/my-appointments item
class DoctorAppointmentModel extends AppointmentSlotEntity {
  const DoctorAppointmentModel({
    required super.id,
    required super.dateTime,
    required super.durationMinutes,
    required super.status,
    required super.visitType,
    required super.isBooked,
    super.patientName,
    super.patientAvatarUrl,
  });

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(json['date'] as String);
    } catch (_) {
      dateTime = DateTime.now();
    }

    final statusStr = (json['status'] as String? ?? '').toLowerCase();

    return DoctorAppointmentModel(
      id: (json['id'] ?? 0).toString(),
      dateTime: dateTime,
      durationMinutes: 30,
      status: DoctorAppointmentStatus.fromString(statusStr),
      visitType: 'كشف',
      isBooked: statusStr != 'cancelled',
      patientName: json['patientName'] as String?,
      patientAvatarUrl: json['imagePath'] as String?,
    );
  }
}