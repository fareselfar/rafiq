import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/patient_profile/data/models/update_profile_request.dart';
import 'package:rafiq/features/patient_profile/data/models/update_profile_response.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_response.dart';
import 'package:rafiq/features/patient_profile/data/models/medical_file_response.dart';
import 'package:rafiq/features/patient_profile/data/models/update_medical_file_record_response.dart';
import 'package:rafiq/features/patient_profile/data/models/update_medical_record_request.dart';
import 'package:rafiq/features/patient_profile/data/models/upload_file_request.dart';
import 'package:rafiq/features/patient_profile/data/models/upload_file_response.dart';
import 'package:rafiq/features/patient_profile/domain/entities/ProfileEntity.dart';

abstract class ProfileRepository {
  Future<Either<Failures, ProfileEntity>> getProfile();
  Future<Either<Failures, ChangePassResponse>> changePass(
    ChangePassRequest request,
  );
  Future<Either<Failures, UpdateProfileResponse>> updateProfile({
    required UpdateProfileRequest request,
  });

  Future<Either<Failure, UploadFileResponse>> uploadFile({
    required UploadFileRequest request,
  });
  Future<Either<Failure, List<MedicalFileResponse>>> getFiles({
    String? fileType,
  });
  Future<Either<Failure, UpdateMedicalRecordResponse>> updateMedicalRecord({
    required UpdateMedicalRecordRequest request,
  });
}
