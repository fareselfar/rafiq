import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/specialization_entity.dart';

abstract class SpecializationRepository {
  Future<Either<Failure, List<SpecializationEntity>>> getSpecializations();
  Future<Either<Failure, SpecializationEntity>> getSpecializationById(
    String id,
  );
}
