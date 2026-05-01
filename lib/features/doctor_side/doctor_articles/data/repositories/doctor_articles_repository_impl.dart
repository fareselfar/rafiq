import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../domain/entities/doctor_articles_entity.dart';
import '../../domain/repositories/doctor_articles_repository.dart';
import '../datasources/doctor_articles_remote_datasource.dart';

class DoctorArticlesRepositoryImpl implements DoctorArticlesRepository {
  final DoctorArticlesRemoteDataSource remoteDataSource;

  DoctorArticlesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DoctorArticlesEntity>>>
  getDoctorArticless() async {
    try {
      final result = await remoteDataSource.getDoctorArticless();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, DoctorArticlesEntity>> getDoctorArticlesById(
    String id,
  ) async {
    try {
      final result = await remoteDataSource.getDoctorArticlesById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
