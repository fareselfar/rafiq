// features/bookings/data/datasources/bookings_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:rafiq/features/patient_side/patient_bookings/data/models/bookings_model.dart';

abstract class BookingsRemoteDataSource {
  Future<List<BookingModel>> getBookings();
  Future<void> cancelBooking(String id);
  // إضافة ميثود التعديل بناءً على الفيجما
  Future<void> rescheduleBooking(String id, String date, String time);
}

class BookingsRemoteDataSourceImpl implements BookingsRemoteDataSource {
  final Dio dio;
  BookingsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<BookingModel>> getBookings() async {
    // لما الـ API يجهز هتشيل التعليق وتستخدم السطر ده:
    // final response = await dio.get('/user/bookings');
    // return (response.data['data'] as List).map((e) => BookingModel.fromJson(e)).toList();

    // حالياً هنرجّع Empty List أو ترمي Exception عشان الـ Repo يعالجه
    throw UnimplementedError("الـ API تحت الإنشاء");
  }

  @override
  Future<void> cancelBooking(String id) async {
    await dio.post('/bookings/$id/cancel');
  }

  @override
  Future<void> rescheduleBooking(String id, String date, String time) async {
    await dio.post(
      '/bookings/$id/reschedule',
      data: {'date': date, 'time': time},
    );
  }
}
