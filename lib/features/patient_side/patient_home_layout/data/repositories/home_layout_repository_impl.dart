import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../domain/entities/home_layout_entity.dart';
import '../../domain/repositories/home_layout_repository.dart';
import '../datasources/home_layout_remote_datasource.dart';

class HomeLayoutRepositoryImpl implements HomeLayoutRepository {
  final HomeLayoutRemoteDataSource remoteDataSource;

  HomeLayoutRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HomeLayoutEntity>>> getHomeLayouts() async {
    try {
      final result = await remoteDataSource.getHomeLayouts();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, HomeLayoutEntity>> getHomeLayoutById(String id) async {
    try {
      final result = await remoteDataSource.getHomeLayoutById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
