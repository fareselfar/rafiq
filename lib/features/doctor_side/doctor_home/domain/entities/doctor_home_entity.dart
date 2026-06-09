// lib/features/doctor_side/doctor_home/domain/entities/doctor_home_entity.dart

import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_article_entity.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_home_stats_entity.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_last_booking_entity.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_today_appointment_entity.dart';

class DoctorHomeEntity {
  final String doctorName;
  final int todayAppointmentsCount;
  final DoctorHomeStatsEntity stats;
  final List<DoctorTodayAppointmentEntity> todaySchedule;
  final List<DoctorArticleEntity> articles;
  final List<DoctorLastBookingEntity> lastBookings;

  const DoctorHomeEntity({
    required this.doctorName,
    required this.todayAppointmentsCount,
    required this.stats,
    required this.todaySchedule,
    required this.articles,
    required this.lastBookings,
  });
}
