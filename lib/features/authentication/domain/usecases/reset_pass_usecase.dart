import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/authentication/data/models/reset_password_request.dart';
import 'package:rafiq/features/authentication/data/models/ResetpasswordResponse.dart';
import 'package:rafiq/features/authentication/domain/repositories/auth_repository.dart';

class ResetPassUsecase {
  ResetPassUsecase(this.repository);
  final AuthenticationRepository repository;
  Future<Either<Failures, ResetPasswordResponse>> call({
    required ResetPasswordRequest request,
  }) {
    return repository.resetPassword(request: request);
  }
}
