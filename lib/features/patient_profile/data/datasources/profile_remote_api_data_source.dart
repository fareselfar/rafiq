import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/utils/constants.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_shared_prefs.dart';
import 'package:rafiq/features/patient_profile/data/models/update_profile_request.dart';
import 'package:rafiq/features/patient_profile/data/models/update_profile_response.dart';
import 'package:rafiq/features/patient_profile/data/datasources/profile_remote_data_source.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_response.dart';
import 'package:rafiq/features/patient_profile/data/models/medical_file_response.dart';
import 'package:rafiq/features/patient_profile/data/models/profile_model.dart';
import 'package:rafiq/features/patient_profile/data/models/update_medical_file_record_response.dart';
import 'package:rafiq/features/patient_profile/data/models/update_medical_record_request.dart';
import 'package:rafiq/features/patient_profile/data/models/upload_file_request.dart';
import 'package:rafiq/features/patient_profile/data/models/upload_file_response.dart';

class ProfileRemoteApiDataSource implements ProfileRemoteDataSource {
  Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final token = await AuthSharedPrefs().getToken();
      var response = await dio.get(
        AppConstants.getProfileEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response.data);
      ProfileModel profile = ProfileModel.fromJson(response.data);
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
    try {
      final token = await AuthSharedPrefs().getToken();
      var response = await dio.post(
        AppConstants.changePassEndpoint,
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
        print("DATA => ${exp.response?.data}");
        message = exp.response?.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to change password");
    }
  }

  @override
  Future<UpdateProfileResponse> updateProfile({
    required UpdateProfileRequest request,
  }) async {
    try {
      final data = request.toJson();
      print("REQUEST => ${request.toJson()}");

      if (request.image != null) {
        data['Image'] = await MultipartFile.fromFile(request.image!.path);
      }
      final token = await AuthSharedPrefs().getToken();
      final response = await dio.put(
        AppConstants.updateProfileEndpoint,
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
  Future<UploadFileResponse> uploadFile({
    required UploadFileRequest request,
  }) async {
    try {
      final token = await AuthSharedPrefs().getToken();

      final data = request.toJson();

      data['File'] = await MultipartFile.fromFile(
        request.file.path,
        filename: request.fileName,
      );

      print('REQUEST => $data');

      final response = await dio.post(
        AppConstants.uploadFileEndpoint,
        data: FormData.fromMap(data),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('UPLOAD RESPONSE => ${response.data}');

      return UploadFileResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('STATUS => ${e.response?.statusCode}');
      print('DATA => ${e.response?.data}');

      String? message;

      if (e.response?.data is Map<String, dynamic>) {
        message = e.response?.data['message'];
      }

      throw RemoteException(message: message ?? 'Failed to upload file');
    }
  }

  @override
  Future<List<MedicalFileResponse>> getFiles({String? fileType}) async {
    try {
      final token = await AuthSharedPrefs().getToken();

      final response = await dio.get(
        AppConstants.getUploadFileEndpoint,
        queryParameters: {if (fileType != null) 'fileType': fileType},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print("FILE TYPE SENT => $fileType");
      return (response.data as List)
          .map((e) => MedicalFileResponse.fromJson(e))
          .toList();
    } on DioException catch (e) {
      String? message;

      if (e.response?.data is Map<String, dynamic>) {
        message = e.response?.data['message'];
      }

      throw RemoteException(message: message ?? 'Failed to fetch files');
    }
  }

  @override
  Future<UpdateMedicalRecordResponse> updateMedicalRecord({
    required UpdateMedicalRecordRequest request,
  }) async {
    try {
      final token = await AuthSharedPrefs().getToken();

      final response = await dio.put(
        AppConstants.updateMedicalRecordEndpoint,
        data: request.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return UpdateMedicalRecordResponse.fromJson(response.data);
    } on DioException catch (e) {
      String? message;

      if (e.response?.data is Map<String, dynamic>) {
        message = e.response?.data['message'];
      }

      throw RemoteException(
        message: message ?? 'Failed to update medical record',
      );
    }
  }
}
