import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp+response.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_request.dart';
import 'package:rafiq/features/authentication/domain/repositories/auth_repository.dart';

class VerifyResetOtpUseCase {
  final AuthenticationRepository repository;

  VerifyResetOtpUseCase(this.repository);

  Future<Either<Failures, VerifyResetOtpResponse>> call({
    required VerifyResetOtpRequest request,
  }) {
    return repository.verifyResetOtp(request: request);
  }
}
