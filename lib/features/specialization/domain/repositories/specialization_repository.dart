import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/specialization/domain/entities/specialization_entity.dart';

abstract class SpecializationRepository {
  Future<Either<Failures, List<SpecializationEntity>>> getSpecializations();
}