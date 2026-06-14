import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_response.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_request.dart';
import 'package:rafiq/features/authentication/domain/repositories/auth_repository.dart';

class VerifyResetOtpUseCase {
  final AuthRepository repository;

  VerifyResetOtpUseCase(this.repository);

  Future<Either<Failure, VerifyResetOtpResponse>> call({
    required VerifyResetOtpRequest request,
  }) {
    return repository.verifyResetOtp(request);
  }
}
