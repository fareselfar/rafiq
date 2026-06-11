import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_response.dart';
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

  @override
  Future<Either<Failures, ChangePassResponse>> changePass(
    ChangePassRequest request,
  ) async {
    try {
      final result = await remoteDataSource.changePass(request);
      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }
}
