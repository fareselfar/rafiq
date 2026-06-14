import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_request.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_response.dart';
import 'package:rafiq/features/authentication/domain/repositories/auth_repository.dart';

class SendResetOtpUseCase {
  final AuthRepository repository;

  SendResetOtpUseCase(this.repository);

  Future<Either<Failure, SendResetOtpResponse>> call({
    required SendResetOtpRequest request,
  }) {
    return repository.sendResetOtp(request);
  }
}
