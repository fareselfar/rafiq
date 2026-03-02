import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/edit_profile_entity.dart';

abstract class EditProfileRepository {
  Future<Either<Failure, List<EditProfileEntity>>> getEditProfiles();
  Future<Either<Failure, EditProfileEntity>> getEditProfileById(String id);
}
