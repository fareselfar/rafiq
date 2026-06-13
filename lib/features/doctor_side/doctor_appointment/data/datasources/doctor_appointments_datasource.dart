// lib/features/doctor_side/doctor_appointments/data/datasources/doctor_appointments_remote_datasource.dart

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rafiq/core/errors/exceptions.dart';
import '../models/add_availability_request_model.dart';
import '../models/weekly_schedule_model.dart';

abstract class DoctorAppointmentsDatasource {
  Future<WeeklyScheduleModel> getWeeklySchedule({required DateTime weekStart});
  Future<void> cancelFullDay({required DateTime day});
  Future<void> cancelSlot({required String slotId});
  Future<void> editSlot({required String slotId, required String newFromTime});
  Future<void> addAvailability({
    required DateTime date,
    required TimeOfDay from,
    required TimeOfDay to,
  });
}

class DoctorAppointmentsRemoteDatasource implements DoctorAppointmentsDatasource {
  final Dio dio;

  DoctorAppointmentsRemoteDatasource({required this.dio});

  @override
  Future<WeeklyScheduleModel> getWeeklySchedule({required DateTime weekStart}) async {
    try {
      final allSlots = <dynamic>[];
      final allAppointments = <dynamic>[];

      for (int i = 0; i < 7; i++) {
        final day = weekStart.add(Duration(days: i));
        final dateStr =
            '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';

        final res = await dio.get(
          '/Availability',
          queryParameters: {'date': dateStr},
        );

        if (res.statusCode == 200 && res.data is List) {
          allSlots.addAll(res.data as List);
        }
      }

      final apptRes = await dio.get('/Appointments/my-appointments');
      if (apptRes.statusCode == 200 && apptRes.data is List) {
        allAppointments.addAll(apptRes.data as List);
      }

      return WeeklyScheduleModel.fromAvailabilityList(
        allSlots,
        allAppointments,
        weekStart,
      );
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  // ← الميثود الصح هنا مش فيها remoteDataSource
  @override
  Future<void> addAvailability({
    required DateTime date,
    required TimeOfDay from,
    required TimeOfDay to,
  }) async {
    try {
      final request = AddAvailabilityRequestModel.fromDateTime(
        date: date,
        from: from,
        to: to,
      );
      await dio.post('/Availability', data: request.toJson());
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> cancelFullDay({required DateTime day}) async {
    try {
      final dateStr =
          '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
      await dio.delete(
        '/Availability/cancel-day',
        queryParameters: {'date': dateStr},
      );
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> cancelSlot({required String slotId}) async {
    try {
      await dio.delete('/Availability/$slotId');
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> editSlot({
    required String slotId,
    required String newFromTime,
  }) async {
    try {
      await dio.put(
        '/Availability/$slotId',
        data: {'fromTime': newFromTime},
      );
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Never _handleError(DioException e) {
    switch (e.response?.statusCode) {
      case 401:
        throw UnauthorizedException(message: 'غير مصرح', statusCode: 401);
      case 404:
        throw ServerException(message: 'الموعد غير موجود', statusCode: 404);
      default:
        if (e.type == DioExceptionType.connectionError) {
          throw NetworkException(message: 'تحقق من اتصالك');
        }
        throw ServerException(
          message: e.response?.data?['message'] ?? 'خطأ في السيرفر',
          statusCode: e.response?.statusCode ?? 500,
        );
    }
  }
}