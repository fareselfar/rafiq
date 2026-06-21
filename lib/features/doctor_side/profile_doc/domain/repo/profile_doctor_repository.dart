import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/create_coupon_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/create_coupon_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_clinic_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_clinic_info_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_doctor_profile_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_payment_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_payment_info_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/entity/Profile_doctor_entity.dart';
import 'package:rafiq/features/patient_profile/data/models/update_profile_response.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_response.dart';

abstract class ProfileDoctorRepository {
  Future<Either<Failures, DoctorProfileEntity>> getDoctorProfile();
  Future<Either<Failures, ChangePassResponse>> changeDoctorPass(
    ChangePassRequest request,
  );
  Future<Either<Failures, UpdateProfileResponse>> updateDoctorProfile({
    required UpdateDoctorProfileRequest request,
  });
  Future<Either<Failure, UpdateClinicInfoResponse>> updateClinicInfo({
    required UpdateClinicInfoRequest request,
  });
  Future<Either<Failures, CreateCouponResponse>> createCoupon(
    CreateCouponRequest request,
  );
  Future<Either<Failures, UpdatePaymentInfoResponse>> updatePaymentInfo({
    required UpdatePaymentInfoRequest request,
  });
}
