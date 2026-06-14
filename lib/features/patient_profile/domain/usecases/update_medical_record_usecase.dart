import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/patient_profile/data/models/update_medical_file_record_response.dart';
import 'package:rafiq/features/patient_profile/data/models/update_medical_record_request.dart';
import 'package:rafiq/features/patient_profile/domain/repositories/profile_repository.dart';

class UpdateMedicalRecordUseCase {
  final ProfileRepository repository;

  UpdateMedicalRecordUseCase({required this.repository});

  Future<Either<Failure, UpdateMedicalRecordResponse>> call({
    required UpdateMedicalRecordRequest request,
  }) {
    return repository.updateMedicalRecord(request: request);
  }
}
