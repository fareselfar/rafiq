import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/login_request.dart';
import 'package:rafiq/features/patient_side/authentication/domain/entities/auth_entity.dart';
import 'package:rafiq/features/patient_side/authentication/domain/repositories/auth_repository.dart';

class LoginUsecase {
  AuthenticationRepository authenticationRepository;
  LoginUsecase({required this.authenticationRepository});
  Future<Either<Failures, AuthEntity>> call({required LoginRequest request}) {
    return authenticationRepository.login(request: request);
  }
}
