import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/specialization/data/datasources/specialization_remote_datasource.dart';
import 'package:rafiq/features/specialization/domain/entities/specialization_entity.dart';
import 'package:rafiq/features/specialization/domain/repositories/specialization_repository.dart';

class SpecializationRepositoryImpl implements SpecializationRepository {
  final SpecializationRemoteDataSource remoteDataSource;

  SpecializationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<SpecializationEntity>>>
  getSpecializations() async {
    try {
      final result = await remoteDataSource.getSpecializations();

      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }
}