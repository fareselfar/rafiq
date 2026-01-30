import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/homee_entity.dart';

abstract class HomeeRepository {
  Future<Either<Failure, List<HomeeEntity>>> getHomees();
  Future<Either<Failure, HomeeEntity>> getHomeeById(String id);
}
