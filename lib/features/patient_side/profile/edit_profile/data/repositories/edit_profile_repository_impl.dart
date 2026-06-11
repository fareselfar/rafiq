import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../domain/entities/edit_profile_entity.dart';
import '../../domain/repositories/edit_profile_repository.dart';
import '../datasources/edit_profile_remote_datasource.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileRemoteDataSource remoteDataSource;

  EditProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<EditProfileEntity>>> getEditProfiles() async {
    try {
      final result = await remoteDataSource.getEditProfiles();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, EditProfileEntity>> getEditProfileById(
    String id,
  ) async {
    try {
      final result = await remoteDataSource.getEditProfileById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
