import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_response.dart';
import 'package:rafiq/features/patient_profile/domain/repositories/profile_repository.dart';

class ChangePassUseCase {
  ChangePassUseCase({required this.repository});

  final ProfileRepository repository;
  Future<Either<Failures, ChangePassResponse>> call({
    required ChangePassRequest request,
  }) async {
    return repository.changePass(request);
  }
}
