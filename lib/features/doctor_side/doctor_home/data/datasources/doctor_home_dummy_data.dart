import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_appointment_status.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_article_entity.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_home_stats_entity.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_last_booking_entity.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_today_appointment_entity.dart';

import '../../domain/entities/doctor_home_entity.dart';

class DoctorHomeDummyData {
  static DoctorHomeEntity loading() {
    return DoctorHomeEntity(
      doctorName: "Doctor Name",
      todayAppointmentsCount: 5,

      stats: const DoctorHomeStatsEntity(
        weeklyAppointments: 12,
        todayBookings: 5,
        monthlyEarnings: 2500,
        rating: 4.8,
      ),

      todaySchedule: List.generate(
        3,
        (index) => const DoctorTodayAppointmentEntity(
          id: "1",
          patientName: "Patient Name",
          patientAvatarUrl: "",
          time: "10:00 AM",
          isNewPatient: false,
          status: DoctorAppointmentStatus.pending,
        ),
      ),

      articles: List.generate(
        2,
        (index) => const DoctorArticleEntity(
          id: "1",
          title: "Medical Article",
          description: "Article Description",
          imageUrl: "",
          publishedSince: "2h ago",
          viewsCount: 120,
        ),
      ),

      lastBookings: List.generate(
        3,
        (index) => const DoctorLastBookingEntity(
          id: "1",
          patientName: "Ahmed Ali",
          patientAvatarUrl: "",
          date: "Today",
          time: "12:00 PM",
          status: DoctorAppointmentStatus.confirmed,
        ),
      ),
    );
  }
}
