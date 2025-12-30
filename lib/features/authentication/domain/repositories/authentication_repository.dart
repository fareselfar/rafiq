import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/authentication_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, List<AuthenticationEntity>>> getAuthentications();
  Future<Either<Failure, AuthenticationEntity>> getAuthenticationById(
    String id,
  );
}
