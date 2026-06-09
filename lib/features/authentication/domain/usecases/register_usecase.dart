import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/authentication/data/models/register_request.dart';
import 'package:rafiq/features/authentication/domain/entities/auth_entity.dart';
import 'package:rafiq/features/authentication/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  AuthenticationRepository authenticationRepository;
  RegisterUsecase({required this.authenticationRepository});
  Future<Either<Failures, AuthEntity>> call({
    required RegisterRequest request,
  }) {
    return authenticationRepository.register(request: request);
  }
}
