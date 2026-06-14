import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/edit_profile/data/models/update_profile_request.dart';
import 'package:rafiq/features/edit_profile/data/models/update_profile_response.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_response.dart';
import 'package:rafiq/features/patient_profile/data/models/medical_file_response.dart';
import 'package:rafiq/features/patient_profile/data/models/update_medical_file_record_response.dart';
import 'package:rafiq/features/patient_profile/data/models/update_medical_record_request.dart';
import 'package:rafiq/features/patient_profile/data/models/upload_file_request.dart';
import 'package:rafiq/features/patient_profile/data/models/upload_file_response.dart';
import 'package:rafiq/features/patient_profile/domain/entities/ProfileEntity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, ProfileEntity>> getProfile() async {
    try {
      final result = await remoteDataSource.getProfile();
      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }

  @override
  Future<Either<Failures, ChangePassResponse>> changePass(
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
  Future<Either<Failures, UpdateProfileResponse>> updateProfile({
    required UpdateProfileRequest request,
  }) async {
    try {
      final result = await remoteDataSource.updateProfile(request: request);

      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UploadFileResponse>> uploadFile({
    required UploadFileRequest request,
  }) async {
    try {
      final result = await remoteDataSource.uploadFile(request: request);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MedicalFileResponse>>> getFiles({
    String? fileType,
  }) async {
    try {
      final result = await remoteDataSource.getFiles(fileType: fileType);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateMedicalRecordResponse>> updateMedicalRecord({
    required UpdateMedicalRecordRequest request,
  }) async {
    try {
      final result = await remoteDataSource.updateMedicalRecord(
        request: request,
      );

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
