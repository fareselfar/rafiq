import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/data_source/profile_doctor_remote_data_source.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/create_coupon_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/create_coupon_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_clinic_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_clinic_info_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_doctor_profile_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_payment_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_payment_info_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/entity/Profile_doctor_entity.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/repo/profile_doctor_repository.dart';
import 'package:rafiq/features/patient_profile/data/models/update_profile_response.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_response.dart';

class ProfileDoctorRepositoryImpl implements ProfileDoctorRepository {
  final ProfileDoctorRemoteDataSource remoteDataSource;

  ProfileDoctorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, DoctorProfileEntity>> getDoctorProfile() async {
    try {
      final result = await remoteDataSource.getDoctorProfile();
      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }

  @override
  Future<Either<Failures, ChangePassResponse>> changeDoctorPass(
    ChangePassRequest request,
  ) async {
    try {
      final result = await remoteDataSource.changePass(request);
      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }

  @override
  Future<Either<Failures, UpdateProfileResponse>> updateDoctorProfile({
    required UpdateDoctorProfileRequest request,
  }) async {
    try {
      final result = await remoteDataSource.updateDoctorProfile(
        request: request,
      );

      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UpdateClinicInfoResponse>> updateClinicInfo({
    required UpdateClinicInfoRequest request,
  }) async {
    try {
      final response = await remoteDataSource.updateClinicInfo(
        request: request,
      );

      return Right(response);
    } on RemoteException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failures, CreateCouponResponse>> createCoupon(
    CreateCouponRequest request,
  ) async {
    try {
      final result = await remoteDataSource.createCoupon(request);

      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }

  @override
  Future<Either<Failures, UpdatePaymentInfoResponse>> updatePaymentInfo({
    required UpdatePaymentInfoRequest request,
  }) async {
    try {
      final result = await remoteDataSource.updatePaymentInfo(request: request);

      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }
}
