// lib/features/doctor_side/doctor_home/data/models/doctor_home_model.dart

import 'package:rafiq/features/doctor_side/doctor_home/data/models/sub_models/doctor_home_stats_model.dart';
import 'package:rafiq/features/doctor_side/doctor_home/data/models/sub_models/doctor_last_booking_model.dart';
import 'package:rafiq/features/doctor_side/doctor_home/data/models/sub_models/doctor_today_appointment_model.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_article_entity.dart';

import '../../domain/entities/doctor_home_entity.dart';

class DoctorArticleModel extends DoctorArticleEntity {
  const DoctorArticleModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.publishedSince,
    required super.viewsCount,
  });

  factory DoctorArticleModel.fromJson(Map<String, dynamic> json) {
    return DoctorArticleModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      publishedSince: json['published_since'] as String,
      viewsCount: json['views_count'] as int,
    );
  }
}

class DoctorHomeModel extends DoctorHomeEntity {
  const DoctorHomeModel({
    required super.doctorName,
    required super.todayAppointmentsCount,
    required super.stats,
    required super.todaySchedule,
    required super.articles,
    required super.lastBookings,
  });

  factory DoctorHomeModel.fromJson(Map<String, dynamic> json) {
    return DoctorHomeModel(
      doctorName: json['doctor_name'] as String,
      todayAppointmentsCount: json['today_appointments_count'] as int,
      stats: DoctorHomeStatsModel.fromJson(
        json['stats'] as Map<String, dynamic>,
      ),
      todaySchedule: (json['today_schedule'] as List)
          .map(
            (e) =>
                DoctorTodayAppointmentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      articles: (json['articles'] as List)
          .map((e) => DoctorArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastBookings: (json['last_bookings'] as List)
          .map(
            (e) => DoctorLastBookingModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
