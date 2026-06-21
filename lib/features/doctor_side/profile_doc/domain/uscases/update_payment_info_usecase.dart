import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_payment_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_payment_info_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/repo/profile_doctor_repository.dart';

class UpdatePaymentInfoUseCase {
  final ProfileDoctorRepository repository;

  UpdatePaymentInfoUseCase({required this.repository});

  Future<Either<Failures, UpdatePaymentInfoResponse>> call({
    required UpdatePaymentInfoRequest request,
  }) {
    return repository.updatePaymentInfo(request: request);
  }
}
