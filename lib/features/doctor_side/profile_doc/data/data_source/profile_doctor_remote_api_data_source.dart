import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/utils/constants.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_shared_prefs.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/data_source/profile_doctor_remote_data_source.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/create_coupon_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/create_coupon_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/doctor_profille_model.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_clinic_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_clinic_info_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_doctor_profile_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_payment_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_payment_info_response.dart';
import 'package:rafiq/features/edit_profile/data/models/update_profile_response.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_response.dart';

class ProfileDoctorRemoteApiDataSource
    implements ProfileDoctorRemoteDataSource {
  Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  @override
  Future<DoctorProfileModel> getDoctorProfile() async {
    try {
      final token = await AuthSharedPrefs().getToken();
      print("ENDPOINT => ${AppConstants.getProfileDoctorEndpoint}");
      print("HEADER => Bearer $token");
      print("DOCTOR TOKEN => $token");
      var response = await dio.get(
        AppConstants.getProfileDoctorEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response.data);
      DoctorProfileModel profile = DoctorProfileModel.fromJson(response.data);
      return profile;
    } catch (exp) {
      String? message;
      if (exp is DioException) {
        print("STATUS => ${exp.response?.statusCode}");
        print("DATA => ${exp.response?.data}");

        if (exp.response?.data is Map<String, dynamic>) {
          message = exp.response?.data["message"];
        } else {
          message = exp.response?.data.toString();
        }
      }
      throw RemoteException(message: message ?? "Failed to fetch profile");
    }
  }

  @override
  Future<ChangePassResponse> changePass(ChangePassRequest request) async {
    print("ENDPOINT => ${AppConstants.changeDoctorPassEndpoint}");
    print("BODY => ${request.toJson()}");
    print("BASE URL => ${dio.options.baseUrl}");
    print(request.toJson());
    try {
      final token = await AuthSharedPrefs().getToken();
      print("TOKEN => $token");
      var response = await dio.post(
        AppConstants.changeDoctorPassEndpoint,
        data: request.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      ChangePassResponse changePassResponse = ChangePassResponse.fromJson(
        response.data,
      );
      return changePassResponse;
    } catch (exp) {
      print(exp);
      String? message;
      if (exp is DioException) {
        print("STATUS => ${exp.response?.statusCode}");
        print(exp.response?.data.runtimeType);
        print(exp.response?.data);
        print(exp.response?.headers);
        message = exp.response?.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to change password");
    }
  }

  @override
  Future<UpdateProfileResponse> updateDoctorProfile({
    required UpdateDoctorProfileRequest request,
  }) async {
    try {
      final data = request.toJson();
      print("REQUEST => ${request.toJson()}");

      if (request.image != null) {
        data['Image'] = await MultipartFile.fromFile(request.image!.path);
      }
      final token = await AuthSharedPrefs().getToken();
      final response = await dio.put(
        AppConstants.updateDoctorProfileEndpoint,
        data: FormData.fromMap(data),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print("UPDATE RESPONSE => ${response.data}");
      return UpdateProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("STATUS => ${e.response?.statusCode}");
      print("DATA => ${e.response?.data}");

      String? message;

      if (e.response?.data is Map<String, dynamic>) {
        message = e.response?.data['message'];
      }

      throw RemoteException(message: message ?? 'Failed to update profile');
    }
  }

  @override
  Future<UpdateClinicInfoResponse> updateClinicInfo({
    required UpdateClinicInfoRequest request,
  }) async {
    try {
      final token = await AuthSharedPrefs().getToken();

      final response = await dio.put(
        AppConstants.updateClinicInfoEndpoint,
        data: request.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return UpdateClinicInfoResponse.fromJson(response.data);
    } on DioException catch (e) {
      String? message;

      if (e.response?.data is Map<String, dynamic>) {
        message = e.response?.data['message'];
      }

      throw RemoteException(message: message ?? 'Failed to update clinic info');
    }
  }

  @override
  Future<CreateCouponResponse> createCoupon(CreateCouponRequest request) async {
    try {
      final token = await AuthSharedPrefs().getToken();

      final response = await dio.post(
        AppConstants.createCouponEndpoint,
        data: request.toJson(),
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return CreateCouponResponse.fromJson(response.data);
    } on DioException catch (e) {
      String? message;

      if (e.response?.data is Map<String, dynamic>) {
        message = e.response?.data["message"];
      }

      throw RemoteException(message: message ?? "Failed to create coupon");
    }
  }

  @override
  Future<UpdatePaymentInfoResponse> updatePaymentInfo({
    required UpdatePaymentInfoRequest request,
  }) async {
    try {
      final token = await AuthSharedPrefs().getToken();

      final response = await dio.put(
        AppConstants.updatePaymentInfoEndpoint,
        data: request.toJson(),
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return UpdatePaymentInfoResponse.fromJson(response.data);
    } on DioException catch (e) {
      String? message;

      print("STATUS => ${e.response?.statusCode}");
      print("DATA => ${e.response?.data}");

      if (e.response?.data is Map<String, dynamic>) {
        message = e.response?.data["message"];
      }

      throw RemoteException(
        message: message ?? "Failed to update payment info",
      );
    }
  }
}
