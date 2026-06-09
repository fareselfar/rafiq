import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/profile/domain/entities/ProfileEntity.dart';

abstract class ProfileRepository {
  Future<Either<Failures, ProfileEntity>> getProfile();
  // Future<Either<Failure, ProfileEntity>> getProfileById(String id);
}
