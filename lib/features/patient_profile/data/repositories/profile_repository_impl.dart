import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/patient_profile/domain/entities/ProfileEntity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, ProfileEntity>> getProfile() async {
    try {
      final result = await remoteDataSource.getProfile();
      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }

  // @override
  // Future<Either<Failure, ProfileEntity>> getProfileById(String id) async {
  //   try {
  //     final result = await remoteDataSource.getProfileById(id);
  //     return Right(result);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(message: e.message));
  //   } on NetworkException catch (e) {
  //     return Left(NetworkFailure(message: e.message));
  //   }
  // }
}
