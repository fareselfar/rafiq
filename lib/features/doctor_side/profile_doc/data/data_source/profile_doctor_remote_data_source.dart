import 'package:rafiq/features/doctor_side/profile_doc/data/models/create_coupon_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/create_coupon_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/doctor_profille_model.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_clinic_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_clinic_info_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_doctor_profile_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_payment_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_payment_info_response.dart';
import 'package:rafiq/features/patient_profile/data/models/update_profile_response.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_response.dart';

abstract class ProfileDoctorRemoteDataSource {
  Future<DoctorProfileModel> getDoctorProfile();
  Future<ChangePassResponse> changePass(ChangePassRequest request);
  Future<UpdateProfileResponse> updateDoctorProfile({
    required UpdateDoctorProfileRequest request,
  });
  Future<UpdateClinicInfoResponse> updateClinicInfo({
    required UpdateClinicInfoRequest request,
  });
  Future<CreateCouponResponse> createCoupon(CreateCouponRequest request);
  Future<UpdatePaymentInfoResponse> updatePaymentInfo({
    required UpdatePaymentInfoRequest request,
  });
}
