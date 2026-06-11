import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/send_otp_request.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/send_otp_response.dart';
import 'package:rafiq/features/patient_side/authentication/domain/repositories/auth_repository.dart';

class SendResetOtpUseCase {
  final AuthenticationRepository repository;

  SendResetOtpUseCase(this.repository);

  Future<Either<Failures, SendResetOtpResponse>> call({
    required SendResetOtpRequest request,
  }) {
    return repository.sendResetOtp(request: request);
  }
}
