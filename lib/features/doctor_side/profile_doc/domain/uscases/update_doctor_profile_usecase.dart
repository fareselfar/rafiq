import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_doctor_profile_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/repo/profile_doctor_repository.dart';
import 'package:rafiq/features/patient_profile/data/models/update_profile_response.dart';

class UpdateDoctorProfileUseCase {
  final ProfileDoctorRepository repository;

  UpdateDoctorProfileUseCase({required this.repository});

  Future<Either<Failures, UpdateProfileResponse>> call({
    required UpdateDoctorProfileRequest request,
  }) {
    return repository.updateDoctorProfile(request: request);
  }
}
