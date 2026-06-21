import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/repo/profile_doctor_repository.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_response.dart';

class ChangeDoctorPassUseCase {
  ChangeDoctorPassUseCase({required this.repository});

  final ProfileDoctorRepository repository;
  Future<Either<Failures, ChangePassResponse>> call({
    required ChangePassRequest request,
  }) async {
    return repository.changeDoctorPass(request);
  }
}
