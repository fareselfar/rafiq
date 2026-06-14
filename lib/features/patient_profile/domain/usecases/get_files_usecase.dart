import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/patient_profile/data/models/medical_file_response.dart';
import 'package:rafiq/features/patient_profile/domain/repositories/profile_repository.dart';

class GetFilesUseCase {
  final ProfileRepository repository;

  GetFilesUseCase({required this.repository});

  Future<Either<Failure, List<MedicalFileResponse>>> call({String? fileType}) {
    return repository.getFiles(fileType: fileType);
  }
}
