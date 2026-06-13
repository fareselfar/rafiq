// lib/features/doctor_side/doctor_appointments/domain/entities/doctor_appointments_entity.dart

enum DoctorAppointmentStatus {
  pending,
  confirmed,
  cancelled,
  completed;

  static DoctorAppointmentStatus fromString(String? raw) {
    switch (raw?.toLowerCase()) {
      case 'confirmed': return DoctorAppointmentStatus.confirmed;
      case 'cancelled': return DoctorAppointmentStatus.cancelled;
      case 'completed': return DoctorAppointmentStatus.completed;
      default:          return DoctorAppointmentStatus.pending;
    }
  }
}

class AppointmentSlotEntity {
  final String id;
  final DateTime dateTime;
  final int durationMinutes;
  final DoctorAppointmentStatus status;
  final String? patientName;
  final String? patientAvatarUrl;
  final String visitType;
  final bool isBooked;

  const AppointmentSlotEntity({
    required this.id,
    required this.dateTime,
    required this.durationMinutes,
    required this.status,
    required this.visitType,
    required this.isBooked,
    this.patientName,
    this.patientAvatarUrl,
  });

  String get timeLabel {
    final h = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final m = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour < 12 ? 'ص' : 'م';
    return '$h:$m $period';
  }

  String get dateLabel {
    const months = [
      '', 'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
    ];
    return '${dateTime.day} ${months[dateTime.month]}';
  }
}

class WeeklyScheduleEntity {
  final DateTime weekStart;
  final Map<DateTime, List<AppointmentSlotEntity>> slotsByDay;

  const WeeklyScheduleEntity({
    required this.weekStart,
    required this.slotsByDay,
  });

  DateTime get weekEnd => weekStart.add(const Duration(days: 6));

  List<AppointmentSlotEntity> slotsForDay(DateTime day) {
    final key = slotsByDay.keys.firstWhere(
      (k) => k.year == day.year && k.month == day.month && k.day == day.day,
      orElse: () => DateTime(day.year, day.month, day.day),
    );
    return slotsByDay[key] ?? [];
  }
}