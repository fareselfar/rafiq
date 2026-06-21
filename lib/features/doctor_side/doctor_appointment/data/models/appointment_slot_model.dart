// lib/features/doctor_side/doctor_appointments/data/models/availability_model.dart

import '../../domain/entities/doctor_appointments_entity.dart';

/// Maps GET /api/Availability response item
class AvailabilitySlotModel extends AppointmentSlotEntity {
  const AvailabilitySlotModel({
    required super.id,
    required super.dateTime,
    required super.durationMinutes,
    required super.status,
    required super.visitType,
    required super.isBooked,
    super.patientName,
    super.patientAvatarUrl,
  });

  factory AvailabilitySlotModel.fromJson(Map<String, dynamic> json) {
    // fromTime: "09:00:00", specificDate: "2026-01-13"
    final dateStr = json['specificDate'] as String? ?? '';
    final fromStr = json['fromTime'] as String? ?? '00:00:00';
    final toStr = json['toTime'] as String? ?? '00:30:00';

    DateTime dateTime;
    try {
      final date = DateTime.parse(dateStr);
      final timeParts = fromStr.split(':');
      dateTime = DateTime(
        date.year, date.month, date.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
    } catch (_) {
      dateTime = DateTime.now();
    }

    // حساب المدة من fromTime و toTime
    int durationMinutes = 30;
    try {
      final from = fromStr.split(':');
      final to = toStr.split(':');
      final fromMins = int.parse(from[0]) * 60 + int.parse(from[1]);
      final toMins = int.parse(to[0]) * 60 + int.parse(to[1]);
      durationMinutes = toMins - fromMins;
    } catch (_) {}

    final isClosed = json['isClosed'] as bool? ?? false;

    return AvailabilitySlotModel(
      id: (json['id'] ?? 0).toString(),
      dateTime: dateTime,
      durationMinutes: durationMinutes,
      status: isClosed
          ? DoctorAppointmentStatus.cancelled
          : DoctorAppointmentStatus.confirmed,
      visitType: isClosed ? 'مغلق' : 'كشف',
      isBooked: isClosed,
    );
  }
}