enum DoctorAppointmentStatus { pending, confirmed, cancelled, completed }


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
    final h = dateTime.hour.toString().padLeft(2, '0');
    final m = dateTime.minute.toString().padLeft(2, '0');
    return '$h:$m';
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
      orElse: () => day,
    );
    return slotsByDay[key] ?? [];
  }
}
