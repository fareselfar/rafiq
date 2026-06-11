import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/home_layout_entity.dart';

abstract class HomeLayoutRepository {
  Future<Either<Failure, List<HomeLayoutEntity>>> getHomeLayouts();
  Future<Either<Failure, HomeLayoutEntity>> getHomeLayoutById(String id);
}
