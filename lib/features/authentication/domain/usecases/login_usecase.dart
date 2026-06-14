import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/authentication/data/models/login_request.dart';
import 'package:rafiq/features/authentication/data/models/login_response.dart';
import 'package:rafiq/features/authentication/domain/repositories/auth_repository.dart';

class LoginUsecase {
  // اسم الـ abstract class هو AuthRepository مش AuthenticationRepository
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future<Either<Failure, LoginResponse>> call({required LoginRequest request}) {
    return authRepository.login(request);
  }
}
