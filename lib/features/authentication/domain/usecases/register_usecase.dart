import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/authentication/data/models/register_request.dart';
import 'package:rafiq/features/authentication/data/models/register_response.dart';
import 'package:rafiq/features/authentication/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  const RegisterUsecase(this.repository);

  Future<Either<Failure, RegisterResponse>> call({
    required RegisterRequest request,
  }) {
    return repository.register(request);
  }
}
