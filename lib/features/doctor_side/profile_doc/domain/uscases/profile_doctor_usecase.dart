import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/entity/Profile_doctor_entity.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/repo/profile_doctor_repository.dart';

class GetProfileDoctorUsecase {
  const GetProfileDoctorUsecase({required this.repository});
  final ProfileDoctorRepository repository;
  Future<Either<Failures, DoctorProfileEntity>> call() {
    return repository.getDoctorProfile();
  }
}
