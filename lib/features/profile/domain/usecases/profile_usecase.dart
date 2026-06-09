import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/profile/domain/entities/ProfileEntity.dart';
import 'package:rafiq/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUsecase {
  const GetProfileUsecase({required this.repository});
  final ProfileRepository repository;
  Future<Either<Failures, ProfileEntity>> call() {
    return repository.getProfile();
  }
}
