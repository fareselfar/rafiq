// lib/features/doctor_side/doctor_home/data/datasources/doctor_home_remote_datasource.dart

import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/exceptions.dart';
import '../models/doctor_home_model.dart';

abstract class DoctorHomeRemoteDataSource {
  Future<DoctorHomeModel> getDoctorHomeData();
}

class DoctorHomeRemoteDataSourceImpl implements DoctorHomeRemoteDataSource {
  final Dio dio;

  DoctorHomeRemoteDataSourceImpl({required this.dio});

  @override
  Future<DoctorHomeModel> getDoctorHomeData() async {
    try {
      final homeRes = await dio.get('/Doctors/GetDoctorHomePageDetails');
      final profileRes = await dio.get('/Doctors/GetProfile');

      final homeJson = homeRes.data as Map<String, dynamic>;
      final doctorName =
          (profileRes.data as Map<String, dynamic>)['fullName'] as String? ??
          '';

      return DoctorHomeModel.fromJson(homeJson, doctorName);
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw UnauthorizedException(
            message: 'غير مصرح، سجل دخول مرة أخرى',
            statusCode: 401,
          );
        case 500:
          throw ServerException(
            message: 'خطأ في السيرفر - تأكد إن الحساب دكتور',
            statusCode: 500,
          );
        default:
          throw ServerException(
            message: e.response?.data?['message'] ?? 'خطأ غير معروف',
            statusCode: e.response?.statusCode ?? 500,
          );
      }
    }
  }
}
