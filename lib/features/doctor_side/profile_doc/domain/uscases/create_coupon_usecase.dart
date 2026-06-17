import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/create_coupon_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/create_coupon_response.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/repo/profile_doctor_repository.dart';

class CreateCouponUseCase {
  final ProfileDoctorRepository repository;

  CreateCouponUseCase({required this.repository});

  Future<Either<Failures, CreateCouponResponse>> call({
    required CreateCouponRequest request,
  }) {
    return repository.createCoupon(request);
  }
}
