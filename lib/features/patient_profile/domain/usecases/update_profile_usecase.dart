import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/edit_profile/data/models/update_profile_request.dart';
import 'package:rafiq/features/edit_profile/data/models/update_profile_response.dart';
import 'package:rafiq/features/patient_profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase({required this.repository});

  Future<Either<Failures, UpdateProfileResponse>> call({
    required UpdateProfileRequest request,
  }) {
    return repository.updateProfile(request: request);
  }
}
