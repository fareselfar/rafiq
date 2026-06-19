import 'package:injectable/injectable.dart';
import 'package:rafiq/features/patient_profile/data/models/update_profile_request.dart';
import 'package:rafiq/features/patient_profile/data/models/update_profile_response.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_response.dart';
import 'package:rafiq/features/patient_profile/data/models/medical_file_response.dart';
import 'package:rafiq/features/patient_profile/data/models/update_medical_file_record_response.dart';
import 'package:rafiq/features/patient_profile/data/models/update_medical_record_request.dart';
import 'package:rafiq/features/patient_profile/data/models/upload_file_request.dart';
import 'package:rafiq/features/patient_profile/data/models/upload_file_response.dart';

import '../models/profile_model.dart';

@singleton
abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<ChangePassResponse> changePass(ChangePassRequest request);
  Future<UpdateProfileResponse> updateProfile({
    required UpdateProfileRequest request,
  });

  Future<UploadFileResponse> uploadFile({required UploadFileRequest request});

  Future<List<MedicalFileResponse>> getFiles({String? fileType});
  Future<UpdateMedicalRecordResponse> updateMedicalRecord({
    required UpdateMedicalRecordRequest request,
  });
}
