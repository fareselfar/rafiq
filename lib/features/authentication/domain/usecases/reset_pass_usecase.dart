import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';

import 'package:rafiq/features/authentication/data/models/reset_password_pesponse.dart';
import 'package:rafiq/features/authentication/data/models/reset_password_request.dart';
import 'package:rafiq/features/authentication/domain/repositories/auth_repository.dart';

class ResetPassUsecase {
  ResetPassUsecase(this.repository);
  final AuthRepository repository;
  Future<Either<Failure, ResetPasswordResponse>> call({
    required ResetPasswordRequest request,
  }) {
    return repository.resetPassword(request);
  }
}
