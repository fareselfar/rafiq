import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/doctor_articles_entity.dart';

abstract class DoctorArticlesRepository {
  Future<Either<Failure, List<DoctorArticlesEntity>>> getDoctorArticless();
  Future<Either<Failure, DoctorArticlesEntity>> getDoctorArticlesById(
    String id,
  );
}
