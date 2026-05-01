// lib/features/doctor_side/doctor_home/data/datasources/doctor_home_remote_datasource.dart

import 'package:rafiq/features/doctor_side/doctor_home/data/models/sub_models/doctor_home_stats_model.dart';
import 'package:rafiq/features/doctor_side/doctor_home/data/models/sub_models/doctor_last_booking_model.dart';
import 'package:rafiq/features/doctor_side/doctor_home/data/models/sub_models/doctor_today_appointment_model.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_appointment_status.dart';

import '../models/doctor_home_model.dart';

abstract class DoctorHomeRemoteDataSource {
  Future<DoctorHomeModel> getDoctorHomeData();
}

/// Mock implementation — replace internals only when real API is ready.
class DoctorHomeRemoteDataSourceMock implements DoctorHomeRemoteDataSource {
  @override
  Future<DoctorHomeModel> getDoctorHomeData() async {
    await Future.delayed(const Duration(milliseconds: 700));

    return DoctorHomeModel(
      doctorName: 'مالك محمد',
      todayAppointmentsCount: 8,
      stats: const DoctorHomeStatsModel(
        weeklyAppointments: 45,
        todayBookings: 12,
        monthlyEarnings: 12000,
        rating: 4.9,
      ),
      todaySchedule: const [
        DoctorTodayAppointmentModel(
          id: 'appt_001',
          patientName: 'سارة علي',
          patientAvatarUrl: '',
          time: '١٠:٣٠ ص',
          isNewPatient: true,
          status: DoctorAppointmentStatus.cancelled,
        ),
        DoctorTodayAppointmentModel(
          id: 'appt_002',
          patientName: 'محمد علي',
          patientAvatarUrl: '',
          time: '١١:٣٠ ص',
          isNewPatient: true,
          status: DoctorAppointmentStatus.confirmed,
        ),
      ],
      articles: const [
        DoctorArticleModel(
          id: 'art_001',
          title: 'نصائح للحفاظ على صحة القلب',
          description:
              'اكتشف أهم الطرق للحفاظ على صحة قلبك وتجنب الأمراض القلبية',
          imageUrl:
              'https://img.freepik.com/free-vector/human-internal-organ-with-heart_1308-103345.jpg',
          publishedSince: 'منذ يومين',
          viewsCount: 1200,
        ),
        DoctorArticleModel(
          id: 'art_002',
          title: 'كيف تحمي نفسك من مرض السكري',
          description: 'نصائح طبية للوقاية من مرض السكري وتحسين نمط الحياة',
          imageUrl:
              'https://img.freepik.com/free-vector/diabetes-infographic_23-2148521013.jpg',
          publishedSince: 'منذ أسبوع',
          viewsCount: 870,
        ),
      ],
      lastBookings: const [
        DoctorLastBookingModel(
          id: 'book_001',
          patientName: 'ياسر علي',
          patientAvatarUrl: '',
          date: '٢٠٢٦/٠٣/١٠',
          time: '١:٣٠ م',
          status: DoctorAppointmentStatus.completed,
        ),
        DoctorLastBookingModel(
          id: 'book_002',
          patientName: 'بسمة أحمد',
          patientAvatarUrl: '',
          date: '٢٠٢٦/٠٣/١٠',
          time: '٣:٣٠ م',
          status: DoctorAppointmentStatus.completed,
        ),
      ],
    );
  }
}