// lib/features/doctor_side/doctor_home/data/repositories/doctor_home_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/exceptions.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/doctor_side/doctor_home/data/datasources/doctor_home_remote_datasource_mock.dart';
import '../../domain/entities/doctor_home_entity.dart';
import '../../domain/repositories/doctor_home_repository.dart';

class DoctorHomeRepositoryImpl implements DoctorHomeRepository {
  final DoctorHomeRemoteDataSource remoteDataSource;

  DoctorHomeRepositoryImpl({
    required this.remoteDataSource,
    required Object networkInfo,
  });

  @override
  Future<Either<Failure, DoctorHomeEntity>> getDoctorHomeData() async {
    try {
      final result = await remoteDataSource.getDoctorHomeData();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
