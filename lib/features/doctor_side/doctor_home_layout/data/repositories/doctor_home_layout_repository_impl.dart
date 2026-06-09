import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../domain/entities/doctor_home_layout_entity.dart';
import '../../domain/repositories/doctor_home_layout_repository.dart';
import '../datasources/doctor_home_layout_remote_datasource.dart';

class DoctorHomeLayoutRepositoryImpl implements DoctorHomeLayoutRepository {
  final DoctorHomeLayoutRemoteDataSource remoteDataSource;

  DoctorHomeLayoutRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DoctorHomeLayoutEntity>>>
  getDoctorHomeLayouts() async {
    try {
      final result = await remoteDataSource.getDoctorHomeLayouts();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, DoctorHomeLayoutEntity>> getDoctorHomeLayoutById(
    String id,
  ) async {
    try {
      final result = await remoteDataSource.getDoctorHomeLayoutById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
