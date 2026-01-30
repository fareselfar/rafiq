import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/specialization_entity.dart';
import '../../domain/repositories/specialization_repository.dart';
import '../datasources/specialization_remote_datasource.dart';

class SpecializationRepositoryImpl implements SpecializationRepository {
  final SpecializationRemoteDataSource remoteDataSource;

  SpecializationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SpecializationEntity>>>
  getSpecializations() async {
    try {
      final result = await remoteDataSource.getSpecializations();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SpecializationEntity>> getSpecializationById(
    String id,
  ) async {
    try {
      final result = await remoteDataSource.getSpecializationById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
