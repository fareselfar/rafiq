import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/patient_profile/data/models/upload_file_request.dart';
import 'package:rafiq/features/patient_profile/data/models/upload_file_response.dart';
import 'package:rafiq/features/patient_profile/domain/repositories/profile_repository.dart';

class UploadFileUseCase {
  final ProfileRepository repository;

  UploadFileUseCase({required this.repository});

  Future<Either<Failure, UploadFileResponse>> call({
    required UploadFileRequest request,
  }) {
    return repository.uploadFile(request: request);
  }
}
