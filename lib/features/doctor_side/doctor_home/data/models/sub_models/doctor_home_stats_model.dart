import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_home_stats_entity.dart';

class DoctorHomeStatsModel extends DoctorHomeStatsEntity {
  const DoctorHomeStatsModel({
    required super.weeklyAppointments,
    required super.todayBookings,
    required super.monthlyEarnings,
    required super.rating,
  });

  factory DoctorHomeStatsModel.fromJson(Map<String, dynamic> json) {
    return DoctorHomeStatsModel(
      weeklyAppointments: json['weekly_appointments'] as int,
      todayBookings: json['today_bookings'] as int,
      monthlyEarnings: (json['monthly_earnings'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
    );
  }
}
