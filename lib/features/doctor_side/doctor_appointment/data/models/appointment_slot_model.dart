// lib/features/doctor_side/doctor_appointments/data/models/appointment_slot_model.dart

import '../../domain/entities/doctor_appointments_entity.dart';

class AppointmentSlotModel extends AppointmentSlotEntity {
  const AppointmentSlotModel({
    required super.id,
    required super.dateTime,
    required super.durationMinutes,
    required super.status,
    required super.visitType,
    required super.isBooked,
    super.patientName,
    super.patientAvatarUrl,
  });

  factory AppointmentSlotModel.fromJson(Map<String, dynamic> json) {
    return AppointmentSlotModel(
      id: json['id'] as String,
      dateTime: DateTime.parse(json['date_time'] as String),
      durationMinutes: json['duration_minutes'] as int,
      status: _parseStatus(json['status'] as String),
      visitType: json['visit_type'] as String,
      isBooked: json['is_booked'] as bool,
      patientName: json['patient_name'] as String?,
      patientAvatarUrl: json['patient_avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date_time': dateTime.toIso8601String(),
        'duration_minutes': durationMinutes,
        'status': status.name,
        'visit_type': visitType,
        'is_booked': isBooked,
        'patient_name': patientName,
        'patient_avatar_url': patientAvatarUrl,
      };

  static DoctorAppointmentStatus _parseStatus(String raw) {
    switch (raw) {
      case 'confirmed':
        return DoctorAppointmentStatus.confirmed;
      case 'cancelled':
        return DoctorAppointmentStatus.cancelled;
      case 'completed':
        return DoctorAppointmentStatus.completed;
      default:
        return DoctorAppointmentStatus.pending;
    }
  }
}

class WeeklyScheduleModel extends WeeklyScheduleEntity {
  const WeeklyScheduleModel({
    required super.weekStart,
    required super.slotsByDay,
  });

  factory WeeklyScheduleModel.fromJson(Map<String, dynamic> json) {
    final rawDays = json['slots_by_day'] as Map<String, dynamic>;
    final slotsByDay = <DateTime, List<AppointmentSlotEntity>>{};

    rawDays.forEach((dateStr, slots) {
      final day = DateTime.parse(dateStr);
      final slotList = (slots as List)
          .map((s) => AppointmentSlotModel.fromJson(s as Map<String, dynamic>))
          .toList();
      slotsByDay[day] = slotList;
    });

    return WeeklyScheduleModel(
      weekStart: DateTime.parse(json['week_start'] as String),
      slotsByDay: slotsByDay,
    );
  }
}
