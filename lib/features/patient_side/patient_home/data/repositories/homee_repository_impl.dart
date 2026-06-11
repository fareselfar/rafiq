import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../domain/entities/homee_entity.dart';
import '../../domain/repositories/homee_repository.dart';
import '../datasources/homee_remote_datasource.dart';

class HomeeRepositoryImpl implements HomeeRepository {
  final HomeeRemoteDataSource remoteDataSource;

  HomeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HomeeEntity>>> getHomees() async {
    try {
      final result = await remoteDataSource.getHomees();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, HomeeEntity>> getHomeeById(String id) async {
    try {
      final result = await remoteDataSource.getHomeeById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
