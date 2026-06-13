// lib/features/doctor_side/doctor_home/data/models/doctor_home_model.dart

import '../../domain/entities/doctor_appointment_status.dart';
import '../../domain/entities/doctor_home_entity.dart';
import '../../domain/entities/doctor_home_stats_entity.dart';
import '../../domain/entities/doctor_today_appointment_entity.dart';

/// Maps /api/Doctors/GetDoctorHomePageDetails response
class DoctorHomeModel extends DoctorHomeEntity {
  const DoctorHomeModel({
    required super.doctorName,
    required super.todayAppointmentsCount,
    required super.stats,
    required super.todaySchedule,
    required super.articles,
    required super.lastBookings,
  });

  factory DoctorHomeModel.fromJson(Map<String, dynamic> json, String doctorName) {
    final rawList = json['listofDayAppointments'] as List? ?? [];

    return DoctorHomeModel(
      doctorName: doctorName,
      todayAppointmentsCount: json['numberOfDayAppointments'] as int? ?? 0,
      stats: DoctorHomeStatsModel.fromJson(json),
      todaySchedule: rawList
          .map((e) => DoctorTodayAppointmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      articles: const [],   // جاي من endpoint ثاني - Article
      lastBookings: const [], // جاي من Appointments endpoint
    );
  }
}

/// Maps stats fields from same response object
class DoctorHomeStatsModel extends DoctorHomeStatsEntity {
  const DoctorHomeStatsModel({
    required super.weeklyAppointments,
    required super.todayBookings,
    required super.monthlyEarnings,
    required super.rating,
  });

  factory DoctorHomeStatsModel.fromJson(Map<String, dynamic> json) {
    return DoctorHomeStatsModel(
      weeklyAppointments: json['numberOfWeekAppointments'] as int? ?? 0,
      todayBookings: json['numberOfDayAppointments'] as int? ?? 0,
      monthlyEarnings: (json['monthProfit'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rate'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/// Maps listofDayAppointments item
class DoctorTodayAppointmentModel extends DoctorTodayAppointmentEntity {
  const DoctorTodayAppointmentModel({
    required super.id,
    required super.patientName,
    required super.patientAvatarUrl,
    required super.time,
    required super.isNewPatient,
    required super.status,
  });

  factory DoctorTodayAppointmentModel.fromJson(Map<String, dynamic> json) {
    // appointmentDate: "2026-02-25T10:00:00"
    final dateStr = json['appointmentDate'] as String? ?? '';
    final time = _formatTime(dateStr);

    return DoctorTodayAppointmentModel(
      id: '',
      patientName: json['patientName'] as String? ?? '',
      patientAvatarUrl: '',
      time: time,
      isNewPatient: false,
      status: DoctorAppointmentStatus.fromString(
        json['appointmentStatus'] as String?,
      ),
    );
  }

  static String _formatTime(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate);
      final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = dt.hour < 12 ? 'ص' : 'م';
      return '$hour:$minute $period';
    } catch (_) {
      return isoDate;
    }
  }
}