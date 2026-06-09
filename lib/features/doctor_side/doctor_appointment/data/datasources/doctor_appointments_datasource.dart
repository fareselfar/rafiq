// lib/features/doctor_side/doctor_appointments/data/datasources/doctor_appointments_datasource.dart

import '../models/appointment_slot_model.dart';
import '../../domain/entities/doctor_appointments_entity.dart';

abstract class DoctorAppointmentsDatasource {
  Future<WeeklyScheduleModel> getWeeklySchedule({
    required String doctorId,
    required DateTime weekStart,
  });
  Future<void> cancelFullDay({required String doctorId, required DateTime day});
  Future<AppointmentSlotModel> editSlot({
    required String slotId,
    required DateTime newDateTime,
    required int newDurationMinutes,
  });
  Future<void> cancelSlot({required String slotId});
}

class DoctorAppointmentsMockDatasource implements DoctorAppointmentsDatasource {
  @override
  Future<WeeklyScheduleModel> getWeeklySchedule({
    required String doctorId,
    required DateTime weekStart,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    // Build Mon–Fri slots for the requested week
    final slotsByDay = <DateTime, List<AppointmentSlotEntity>>{};

    for (int dayOffset = 0; dayOffset < 5; dayOffset++) {
      final day = weekStart.add(Duration(days: dayOffset));
      slotsByDay[day] = _buildDaySlots(day);
    }

    return WeeklyScheduleModel(
      weekStart: weekStart,
      slotsByDay: slotsByDay,
    );
  }

  List<AppointmentSlotEntity> _buildDaySlots(DateTime day) {
    // Monday 13 Jan matches the design exactly
    final isFeatureDay = day.weekday == DateTime.monday;

    if (isFeatureDay) {
      return [
        AppointmentSlotModel(
          id: 'slot_${day.day}_1',
          dateTime: DateTime(day.year, day.month, day.day, 9, 0),
          durationMinutes: 30,
          status: DoctorAppointmentStatus.pending,
          visitType: 'كشف',
          isBooked: true,
          patientName: 'على محمد',
          patientAvatarUrl: '',
        ),
        AppointmentSlotModel(
          id: 'slot_${day.day}_2',
          dateTime: DateTime(day.year, day.month, day.day, 9, 30),
          durationMinutes: 30,
          status: DoctorAppointmentStatus.pending,
          visitType: 'كشف',
          isBooked: true,
          patientName: 'أحمد محدث',
          patientAvatarUrl: '',
        ),
        AppointmentSlotModel(
          id: 'slot_${day.day}_3',
          dateTime: DateTime(day.year, day.month, day.day, 10, 0),
          durationMinutes: 30,
          status: DoctorAppointmentStatus.cancelled,
          visitType: 'وقت السراحة',
          isBooked: false,
          patientName: null,
        ),
        AppointmentSlotModel(
          id: 'slot_${day.day}_4',
          dateTime: DateTime(day.year, day.month, day.day, 10, 30),
          durationMinutes: 30,
          status: DoctorAppointmentStatus.confirmed,
          visitType: 'متابعة',
          isBooked: false,
          patientName: null,
        ),
        AppointmentSlotModel(
          id: 'slot_${day.day}_5',
          dateTime: DateTime(day.year, day.month, day.day, 11, 0),
          durationMinutes: 30,
          status: DoctorAppointmentStatus.confirmed,
          visitType: 'كشف',
          isBooked: false,
          patientName: null,
        ),
      ];
    }

    // Generic day — mix of booked + free
    return [
      AppointmentSlotModel(
        id: 'slot_${day.day}_1',
        dateTime: DateTime(day.year, day.month, day.day, 9, 0),
        durationMinutes: 30,
        status: DoctorAppointmentStatus.confirmed,
        visitType: 'كشف',
        isBooked: true,
        patientName: 'مريم سالم',
        patientAvatarUrl: '',
      ),
      AppointmentSlotModel(
        id: 'slot_${day.day}_2',
        dateTime: DateTime(day.year, day.month, day.day, 10, 0),
        durationMinutes: 30,
        status: DoctorAppointmentStatus.confirmed,
        visitType: 'متابعة',
        isBooked: false,
      ),
    ];
  }

  @override
  Future<void> cancelFullDay({
    required String doctorId,
    required DateTime day,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    // API call goes here
  }

  @override
  Future<AppointmentSlotModel> editSlot({
    required String slotId,
    required DateTime newDateTime,
    required int newDurationMinutes,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return AppointmentSlotModel(
      id: slotId,
      dateTime: newDateTime,
      durationMinutes: newDurationMinutes,
      status: DoctorAppointmentStatus.confirmed,
      visitType: 'كشف',
      isBooked: false,
    );
  }

  @override
  Future<void> cancelSlot({required String slotId}) async {
    await Future.delayed(const Duration(milliseconds: 400));
  }
}
