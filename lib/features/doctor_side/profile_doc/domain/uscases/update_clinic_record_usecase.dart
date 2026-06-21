import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_clinic_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_clinic_info_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/repo/profile_doctor_repository.dart';

class UpdateClinicInfoUseCase {
  final ProfileDoctorRepository repository;

  UpdateClinicInfoUseCase({required this.repository});

  Future<Either<Failure, UpdateClinicInfoResponse>> call({
    required UpdateClinicInfoRequest request,
  }) {
    return repository.updateClinicInfo(request: request);
  }
}
