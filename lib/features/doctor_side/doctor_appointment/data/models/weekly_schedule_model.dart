// lib/features/doctor_side/doctor_appointments/data/models/weekly_schedule_model.dart

import 'package:rafiq/features/doctor_side/doctor_appointment/data/models/appointment_slot_model.dart';

import '../../domain/entities/doctor_appointments_entity.dart';
import 'appointment_model.dart';

class WeeklyScheduleModel extends WeeklyScheduleEntity {
  const WeeklyScheduleModel({
    required super.weekStart,
    required super.slotsByDay,
  });

  /// بنبني الـ WeeklySchedule من قائمة الـ slots بتاعة يوم معين
  factory WeeklyScheduleModel.fromAvailabilityList(
    List<dynamic> availabilities,
    List<dynamic> appointments,
    DateTime weekStart,
  ) {
    final slotsByDay = <DateTime, List<AppointmentSlotEntity>>{};

    // تجميع الـ availability slots
    for (final item in availabilities) {
      final slot = AvailabilitySlotModel.fromJson(item as Map<String, dynamic>);
      final dayKey = DateTime(slot.dateTime.year, slot.dateTime.month, slot.dateTime.day);
      slotsByDay.putIfAbsent(dayKey, () => []).add(slot);
    }

    // تجميع الـ appointments (حجوزات المرضى)
    for (final item in appointments) {
      final appt = DoctorAppointmentModel.fromJson(item as Map<String, dynamic>);
      final dayKey = DateTime(appt.dateTime.year, appt.dateTime.month, appt.dateTime.day);
      
      // لو مش موجود في الـ availability نضيفه
      final existing = slotsByDay[dayKey];
      if (existing == null) {
        slotsByDay[dayKey] = [appt];
      } else {
        // نحدث الـ slot الموجود لو نفس الوقت
        final sameTime = existing.any(
          (s) => s.dateTime.hour == appt.dateTime.hour &&
                 s.dateTime.minute == appt.dateTime.minute,
        );
        if (!sameTime) existing.add(appt);
      }
    }

    return WeeklyScheduleModel(
      weekStart: weekStart,
      slotsByDay: slotsByDay,
    );
  }
}